#!/usr/bin/env bash

# Set directories
TEMPLATE_DIR="templates"
INCLUDE_DIR="includes"
PAGE_DIR="pages"
OUTPUT_DIR="output"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to process includes
process_includes() {
    local template_content="$1"
    while [[ "$template_content" =~ \{\#\ include\ ([^\}]+)\ \} ]]; do
        include_file="${BASH_REMATCH[1]}.html"
        include_path="$INCLUDE_DIR/$include_file"
        if [[ -f "$include_path" ]]; then
            include_content="$(<"$include_path")"
            template_content="${template_content//\{# include ${BASH_REMATCH[1]} \}/$include_content}"
        else
            echo "Warning: Include file '$include_file' not found."
            break
        fi
    done
    echo "$template_content"
}

# Function to replace placeholders with content
replace_placeholders() {
    local content="$1"
    local key="$2"
    local value="$3"
    echo "${content//\{\{$key\}\}/$value}"
}

# Function to process inject blocks
process_inject_block() {
    local content="$1"
    local sections=($2)
    local section_titles=($3)
    local output=""

    # Extract the inject block
    local inject_start="{# inject}"
    local inject_end="{/# inject}"
    local before_block=""
    local after_block=""
    local inject_block=""
    local in_block=false

    while IFS= read -r line; do
        if [[ "$line" == *"$inject_start"* ]]; then
            in_block=true
            continue
        elif [[ "$line" == *"$inject_end"* ]]; then
            in_block=false
            continue
        fi

        if $in_block; then
            inject_block+="$line\n"
        elif ! $in_block && [[ -z "$inject_block" ]]; then
            before_block+="$line\n"
        else
            after_block+="$line\n"
        fi
    done <<< "$content"

    # Render the sections
    for i in "${!sections[@]}"; do
        local rendered_section="$inject_block"
        rendered_section="$(replace_placeholders "$rendered_section" "title" "${section_titles[$i]}")"
        rendered_section="$(replace_placeholders "$rendered_section" "content" "${sections[$i]}")"
        output+="$rendered_section"
    done

    # Combine everything
    echo -e "$before_block$output$after_block"
}

# Process each markdown file in pages directory
for markdown_file in "$PAGE_DIR"/*.md; do
    # Extract metadata and sections
    template=""
    title=""
    sections=()
    section_titles=()
    while IFS= read -r line; do
        if [[ "$line" == "# Meta"* ]]; then
            while IFS= read -r meta_line && [[ "$meta_line" != "" ]]; do
                if [[ "$meta_line" == "- template: "* ]]; then
                    template="${meta_line#- template: }"
                elif [[ "$meta_line" == "- title: "* ]]; then
                    title="${meta_line#- title: }"
                fi
            done
        elif [[ "$line" == "# Section "* ]]; then
            section_title="${line#\# Section }"
            section_titles+=("$section_title")
            section=""
            while IFS= read -r section_line && [[ "$section_line" != "---" ]]; do
                section+="$section_line\n"
            done
            sections+=("$section")
        fi
    done < "$markdown_file"

    # Load and process template
    template_file="$TEMPLATE_DIR/$template.html"
    if [[ -f "$template_file" ]]; then
        page_content="$(<"$template_file")"
        page_content="$(process_includes "$page_content")"

        # Replace placeholders with metadata
        page_content="$(replace_placeholders "$page_content" "title" "$title")"

        # Process the inject block
        page_content="$(process_inject_block "$page_content" "${sections[*]}" "${section_titles[*]}")"

        # Save output
        output_file="$OUTPUT_DIR/$(basename "$markdown_file" .md).html"
        echo -e "$page_content" > "$output_file"
        echo "Generated: $output_file"
    else
        echo "Error: Template '$template_file' not found for page '$markdown_file'."
    fi

done

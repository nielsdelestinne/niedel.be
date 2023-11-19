---
layout: post
title:  "Writing test-first data migrations with Flyway"
date:   2023-10-09
author: "Niels Delestinne"
categories: back-end PostgreSQL Flyway
comments: false
---

Anyone who has worked with persistent data knows how challenging data migrations can be. They're difficult to write and crucial to execute flawlessly. This article explores a test-first approach to tackle this challenge.

<!--more-->

## What Are Data Migrations?
When you hear "data migrations," you might think of complete database migrations from one structure to another. For instance, merging data from an acquired application into another application. However, that's not the kind of data migration I'm discussing here.

*So, what exactly are you referring to?*

I'm talking about incremental changes to the database structure; like adding new columns, enforcing column constraints, altering stored JSON objects, or creating new tables. Such changes inevitably affect the existing data.

### An Example
Consider an application that allows users to create a Product. Suppose 100 products have already been created. Now, a new feature is in development that requires each product to have a description.

To migrate the data correctly, we need a script that:

1. Adds an optional description column to the Product table.
2. Populates a default or calculated description for each existing Product.
3. Sets the description column to NOT NULL.

Upon deploying the new feature, this data migration script will be executed.

## How to Test Data Migrations?
Proper testing of data migrations is critical for several reasons:
- They modify production data.
- Data errors are easy to overlook.
- Failures can halt production deployments.

There's no one-size-fits-all approach for testing data migrations; each has its own trade-offs. However, automation and repeatability are non-negotiable.

The approach I propose focuses on test-first, integration testing of data migrations.

## Test-First Approach
Adopting a test-first methodology for writing data migrations offers several advantages:
- It prompts you to consider edge cases, which are often abundant in production.
- It gives immediate feedback during development.
- It offers a safe and repeatable environment, ideal for junior developers to hone their skills.

Nevertheless, these tests should be complemented by executing the migration on actual production data. One effective way to do this is by setting up a *staging* environment with a recent database backup and then applying the migration scripts.

## A Working Setup (Demo)
> The demo setup uses Java 17, Spring Boot 3, JUnit 5, Flyway 9, and Testcontainers 1.19.

Here's a glimpse into the runtime execution flow of the integration test:

1. The test for migration N starts.
2. Migrations up to N-1 are applied.
3. Test data following the old structure is inserted.
4. Migration N is applied.
5. Test assertions are evaluated.
6. The test concludes, either successfully or otherwise.

A simple integration test looks like this:
{% highlight java %}
class V0005ProductDescriptionMigrationTest extends MigrationTest {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  @RegisterExtension
  static MigrationTestExtension migrationExtension =
    createMigrationExtension(5, "V005_testData.sql");

  @Test
  void productionDescriptionIsAdded_dataMigrated_andMadeRequired() {
    var firstProduct = jdbcTemplate.queryForList("SELECT id, description FROM product").get(0);
    assertThat(firstProduct).containsEntry("id", 0);
    assertThat(firstProduct).containsEntry("description", "No description");
  }

  // additional tests

}
{% endhighlight %}

The most vital part of this setup is the extension that is being registered:

{% highlight java %}
public class MigrationTestExtension implements BeforeAllCallback, BeforeEachCallback {

  // Initialize or assign your test-container instance (e.g. myDb)

  @Override
  public void beforeAll(ExtensionContext context) {
      myDb.start();
  }

  @Override
  public void beforeEach(ExtensionContext context) throws Exception {
  var flywayBean = SpringExtension.getApplicationContext(context).getBean(Flyway.class);
  var flywayConfiguration = Flyway.configure().configuration(flywayBean.getConfiguration());

    flywayConfiguration
      .cleanDisabled(false).load()
      .clean();

    // All migrations up to N-1 are applied
    flywayConfiguration
      .target(currentMigrationVersion)
      .load()
      .migrate();

    // Test data is inserted
    executeSqlScript(myDb.createConnection(""), createEncodedResource(nameOfTestDataScript));

    // Migration N is applied
    flywayConfiguration
      .target(newMigrationVersion)
      .load()
      .migrate();
  }
}

{% endhighlight %}

## Some final advice
### Remove obsolete tests
Once certain migrations are successfully applied to production, consider removing their corresponding tests. Keeping them will only slow down your build and add unnecessary complexity.

### Avoid using domain objects in tests
Don't use objects from your domain model in your migration tests. These tests are designed to reflect a specific snapshot of your database structure, which your domain model might not accurately represent.

### Use private, nested POJOs for object mapping
If you need to map to an object in your test, add a private, nested Plain Old Java Object (POJO) within the test itself. This ensures that the test remains self-contained and isolated from the domain model.
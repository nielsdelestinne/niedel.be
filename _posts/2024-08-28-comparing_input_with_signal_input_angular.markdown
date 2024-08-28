---
layout: post
title:  "Comparing @Input() with the new Signal input in Angular"
date:   2024-08-28
author: "Niels Delestinne"
categories: angular signal input
comments: false
---

Angular has been receiving a steady stream of new and interesting features over recent years. One of those is Signals, an optimized system that tracks how and where the state is used.
In this article, we will look at how Signals can be used as inputs and compare them with other approaches using the @Input() decorator.

<!--more-->

## Signals?

If you're not familiar with Signals, I highly recommend you read the [official Angular Signals guide](https://angular.dev/guide/signals) first.

## Example feature

Imagine there already exists an Angular application in which the HTTP-based API of a smart meter — which tracks the active power consumption of a household — is called every second.

The active power consumption is returned as a response:
- A positive value means the household has a surplus of energy (e.g., generated via solar panels).
- A negative value means power is being taken from the power grid.

We will create a new component that does the following:
- Show a green orb if the active power is 0 or positive.
- Show a red orb if the active power is negative.

> A pure pipe would be a better and more performant fit for this simplistic extension to the application.
> However, for the sake of the article and for what we're trying to demonstrate, we will make use of a component.

## @Input() decorator and set property

We start by using the `@Input()` decorator combined with a set property (setter).

{% highlight javascript %}
import {ChangeDetectionStrategy, Component, Input} from '@angular/core';

@Component({
    selector: 'nd-active-power-indicator',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `{% raw %}<span>{{ activePowerIndicator }}</span>{% endraw %}`
})
export class ActivePowerIndicatorComponent {
    activePowerIndicator!: string;

    @Input({required: true}) set activePower (activePowerValue: number) {
        this.activePowerIndicator = activePowerValue < 0 ? "🔴" : "🟢";
    }
}
{% endhighlight %}

The component can be included in the application by its selector `nd-active-power-indicator`:

{% highlight html %}
@if (smartMeterResult$ | async as smartMeterResult) {
    <nd-active-power-indicator [activePower]="smartMeterResult.activePower"/>
}
{% endhighlight %}

_The template code snippet shown above will remain identical in the subsequent solutions and will therefore not be repeated._

### Observations

Although this approach correctly updates and renders the indicator every second, it's not the most elegant solution.
The setter property forces us to introduce a non-private field `activePowerIndicator`. We can do better.

## @Input() decorator with transform function

We rework our previous solution by providing a `transform` function to the `@Input()` decorator.

{% highlight javascript %}
import {ChangeDetectionStrategy, Component, Input} from '@angular/core';

@Component({
    selector: 'nd-active-power-indicator',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `{% raw %}<span>{{ activePower }}</span>{% endraw %}`
})
export class ActivePowerIndicatorComponent {
    @Input({required: true, transform: toIndicator}) activePower!: string;
}

function toIndicator(activePowerValue: number): string {
    return activePowerValue < 0 ? "🔴" : "🟢";
}
{% endhighlight %}

### Observations

While this solution leverages the built-in transform functionality of `@Input()`, there are some drawbacks.

For starters, the type the `@Input()` decorator accepts (`number`) is defined in the `transform` function, not in the declaration of the `@Input()` decorated field (`string`). This is counterintuitive.

Additionally, the @Input() field activePower takes a numerical value in kWh, but in the template, we display an indicator (orb), not the actual value.

- This distinction isn't clear in the code because activePower is used for both the raw value and its transformed indicator.

Using an alias, this ambiguity can be resolved:

{% highlight javascript %}
import {ChangeDetectionStrategy, Component, Input} from '@angular/core';

@Component({
    selector: 'nd-active-power-indicator',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `{% raw %}<span>{{ activePowerIndicator }}</span>{% endraw %}`
})
export class ActivePowerIndicatorComponent {
    @Input({required: true, alias: 'activePower', transform: toIndicator}) activePowerIndicator!: string;
}

function toIndicator(activePowerValue: number): string {
    return activePowerValue < 0 ? "🔴" : "🟢";
}
{% endhighlight %}

Finally, no instance method can be used as the `transform` function; it has to be:
- A defined function (as in the code snippet above).
- An inline lambda method.
- A lambda method defined as a `const` or `let` variable.

The solution below, using an inline lambda, would also work, be it only for small function bodies.

{% highlight javascript %}
import {ChangeDetectionStrategy, Component, Input} from '@angular/core';

@Component({
    selector: 'nd-active-power-indicator',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
        {% raw %}<span>{{ activePowerIndicator }}</span>{% endraw %}
    `
})
export class ActivePowerIndicatorComponent {
    @Input({required: true, transform: (activePowerValue: number) => activePowerValue < 0 ? "🔴" : "🟢"}) activePowerIndicator!: string;
}
{% endhighlight %}

In comparing the setter with the transform function, the transform function is often the better choice as it improves readability, clarity, and is specifically designed for transformation tasks. 

- If you need additional control or more complex logic beyond transformation, a setter might be more appropriate.

## Signal input

We replace the `@Input()` decorated field with a Signal input and make use of the Signal input's transformation method support.

{% highlight javascript %}
import {ChangeDetectionStrategy, Component, input} from '@angular/core';

@Component({
    selector: 'nd-active-power-indicator',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `{% raw %}<span>{{ activePowerIndicator() }}</span>{% endraw %}`
})
export class ActivePowerIndicatorComponent {
    activePowerIndicator = input.required<string, number>({
        alias: 'activePower',
        transform: (value: number) => this.toIndicator(value)
    });

    toIndicator(activePowerValue: number): string {
        return activePowerValue < 0 ? "🔴" : "🟢";
    }
}
{% endhighlight %}

### Observations

As with `@Input()` decorated input, we can...

- enforce that an input value is required.
- provide an alias if desired.
- provide a transform. However, for Signal inputs, you provide an (instance) method instead of a function.

All of these were applied to our solution above.

_Furthermore, compared to decorator-based @Input, signal inputs provide numerous benefits:_

- _Signal inputs are more type-s_afe: required inputs do not require initial values or tricks to tell TypeScript that an input always has a value. Furthermore, transforms are automatically checked to match the accepted input values._
- _Signal inputs, when used in templates, will automatically mark OnPush components as dirty._
- _Values can be easily derived whenever an input changes using `computed`._
- _Easier and more localized monitoring of inputs using `effect` instead of `ngOnChanges` or setters._

_The excerpt above is taken from [the official Angular Signal guide](https://angular.dev/guide/signals/inputs#why-should-we-use-signal-inputs-and-not-input)._

## Signal input with transformation pipe

A Signal input accepts an instance method instead of a function for its transformer. This opens up the possibility to inject and reuse an existing pipe.

- _Although pure pipes come with performance optimizations, there are none to be gained in this simplistic use case._

The pipe:

{% highlight javascript %}
import {Pipe, PipeTransform} from '@angular/core';

@Pipe({
    name: 'toIndicator',
    standalone: true
})
export class ToIndicatorPipe implements PipeTransform {
    transform(activePowerValue: number): string {
        return activePowerValue < 0 ? "🔴" : "🟢";
    }
}
{% endhighlight %}

The Signal input updated with the injected pipe:

{% highlight javascript %}
import {ChangeDetectionStrategy, Component, inject, input} from '@angular/core';
import {ToIndicatorPipe} from "../to-indicator.pipe";

@Component({
    selector: 'nd-active-power-indicator',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    providers: [ToIndicatorPipe],
    template: `{% raw %}<span>{{ activePowerIndicator() }}</span>{% endraw %}`
})
export class ActivePowerIndicatorComponent {
    private toIndicator = inject(ToIndicatorPipe);

    activePowerIndicator = input.required<string, number>({
        alias: 'activePower',
        transform: (value: number) => this.toIndicator.transform(value)
    });
}
{% endhighlight %}

## Conclusion

while both `@Input()` decorators and Signal inputs effectively handle data binding in Angular, and all presented solutions in this article provide the same behavior, Signals offer a more reactive and streamlined approach. 

`@Input()` decorators, whether using setters or transform functions, are familiar and versatile. Signals, on the other hand, provide stronger type safety, automatic change detection, and can be considered as a step forward. 

For inputs, Signals represent a cleaner, more modern alternative to the traditional `@Input()` decorator, making them your default option on (future) projects.

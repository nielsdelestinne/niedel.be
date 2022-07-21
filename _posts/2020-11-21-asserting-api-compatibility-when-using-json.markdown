---
layout: post
title:  "Asserting API Compatibility when using JSON"
date:   2020-11-21
author: "Niels Delestinne"
categories: java api json
comments: true
---

It is often too easy to break API compatibility when using JSON as the data-interchange format. In an 
application landscape where we have many producing applications and even more consuming applications, 
it's vital to enforce and assert API compatibility.

## API Compatibility

When working with HTTP-based REST(ful) web APIs or even with an event-driven architecture, JSON is frequently used as the 
data-interchange format. The exchanged JSON messages themselves are often the implicit 'contracts' between the producer and consumer.
Not having an explicit contract makes it hard to enforce and maintain **API compatibility** between producer and consumer(s), 
the 'contract' can be easily broken by accident: 
- E.g. The serialization performed by the producer is not properly aligned with the deserialization performed by the consumer. 
For example, when using Jackson, the `ObjectMapper` can be configured slightly different in the producer's codebase compared to the consumer's codebase.
- E.g. The producer renames a field in its domain, which happens to propagate to the object-to-serialize and thus directly affects 
the JSON message and the implicit 'contract' it represents.

> An API consists of **endpoints / services** that accept input and return output (using **messages**).
> API compatibility involves - and can be affected by - both. In the article we will solely focus on the **messages**.

We should stop treating JSON messages as implicit, second class citizen, contracts. Let's find out how!

## Asserting API Compatibility

If you have a project landscape that:
- Involves many applications
- And all of these applications communicate with each other (e.g. microservices architecture)
- And all of these applications are maintained by different development teams

Then, ensuring API compatibility becomes an active, non-trivial issue. 

So, how can we better enforce or maintain API compatibility when using JSON as the data-interchange format?

### JSON Schema

Let's take a look at **JSON Schema**. JSON Schema is a non-standardized specification for describing the data structure of your JSON messages. You make the
message structure (contract) up front & explicit. It enables a test-first approach and allows the contract to be asserted in a lightweight test. Schemas are a great solution for enforcing API compatibility.
- Unfortunately, JSON Schema is considered (too) **verbose** by many developers. it uses JSON as its Intermediate Definition Language (IDL), which certainly contributes to the verboseness. 
It is also considered to have a steep learning curve (which can be ruled as rather subjective).

### End to end testing

A different approach and solution is to perform some kind of API compatibility testing. We could write an end-to-end test in which we perform
an actual call from the consumer to the producer. If either producer or consumer made a change that negatively impacted API compatibility,
the test will fail. This approach has some downsides to it, some of the more prominent are:
- Expensive: setting up & running two (dockerized) applications to perform a test will result in a resource-expensive and slow(er) test.
- Late feedback: With this approach, you will be notified during (test execution) runtime not during compile-time.

### Contract testing

Another solution is to use contract-testing tools like PACT or Spring Cloud Contract (Java). These tools allow to create 
explicit message contracts on top of your JSON messages. They offer integrations with existing testing frameworks (e.g. JUnit5).
The contract these tools generate are an extended version of what a schema is, as they do not only allow to define the message structure but also allow to include 
**business rules, constraints and specific (producer/consumer) meta information**.
- These tests generally perform much better than end-to-end tests (as they only test the contract and do not require a running producer & consumer application). 
However, they do require a setup in which the generated contracts are accessible by both consumer and producer codebase. This can go as far as setting up 'Broker' service (e.g. PACT broker).
- No compile-time 'safety', feedback of a contract being broken is received during test execution.
- Using contract-testing tools purely for asserting API compatibility (something a schema can do as well) can be considered overkill and might
not justify the overhead of the technical setup and learning curve that is required. 

> If enforcing and maintaining API compatibility is a serious and recurring problem on your project, and you want to keep using JSON as the data-interchange format, consider using a contract-testing tool (like PACT) or adopt JSON schema (or an alternative schema for JSON).

## Resources

The following official resources contain more information on the discussed topics above:
- [JSON Schema](https://json-schema.org/) 
- [PACT](https://pact.io/) 
- [PACT Documentation](https://docs.pact.io/) 
- [Spring Cloud Contract](https://spring.io/projects/spring-cloud-contract) 
- [Spring Cloud Contract Documentation](https://cloud.spring.io/spring-cloud-contract/reference/html/) 

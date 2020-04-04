# Chapter 2

## Identifiers (Key) - Primary Key

1. Defination: an attribute (or combination of attributes) that uniquely identifies individual instances of an entity type (commonly called, PK - Primary Key, data value of PK can not be repeated and can not be NULL)
2. one table can only have one PK

## Degree of Relationships

1. Unary Relationship 

   1. One entity relatied to another of the same entity type, e.g. employee and manager 

   2. Can be one-to-one

   3. Can be one-to-many


2. Binary Relationship

   1. Entities of two different types related to each other

   2. One-to-one

   3. One-to-many


3. Ternary Relationship

   1. Entities of three different types related to each other

## Cardinalities

1. Different cardinality constraints

2. When have many to mant reationship, need to create an intersect entity:

## Supertypes and Subtypes

1. PK of subtypes are automatically inherited by subtypes

2. Generalization and Specialization

   1. Generalizaiton
      1. The process of defining a more general entity type from a set of more specialized entity types. (BOTTOM-UP)
      2. Identify the common attributes and cross them up
   2. Specialization
      1. The process of defining one or more subtypes of the supertype and forming super type/subtype relationships. (TOP-DOWN)
      2. Consider super type first, then subtype

3. Constraints in Supertype/Subtype relationships

   1. Completeness Constraints: Whether an instance of a supertype MUST also be a member of at least one subtype

      1. Total specialization rule: Yes (indicated by double line)

      2. Partial specialization rule: No (indicated by single line)

   2. Disjointness Constraints: Whether an instance of a supertype may simultaneously be a member of two (or more) subtypes

      1. Disjoint Rule: An instance of the supertype can be only ONE of the subtyes

      2. Overlap Rule: An instance of the supertype could be more than one of the subtypes
    
   3. Subtype Discriminator: An atribute of the supertype whose values determine the target subtypes

      1. Disjoint: a simple attribute with alternative values to indicate the possible subtypes

      2. Overlapping: a composite attribute whose subparts pertain to different subtypes. Each subpart contains a Boolean value to indicate whether or not the instance belongs to the associated subtype


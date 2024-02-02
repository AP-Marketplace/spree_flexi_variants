# SpreeFlexiVariants

This is a [spree](http://spreecommerce.com) extension that solves two use cases related to variants. I call them **Ad Hoc Options** and **Product Customizations**.

This extension is upgraded version of [old spree_flexi_variants](https://github.com/QuintinAdam/spree_flexi_variants)
### Ad Hoc Options

Use these when have numerous (possibly price-altering) product options and you don't want to create variants for each combination.

You can also restrict certain combinations of options from coexisting.  These are called **Ad Hoc Exclusions**.

### Product Customizations

Use these when you want the ability to provide a highly customized product e.g. "Cut to length 5.82cm", "Engrave 'thanks for the memories'", "Upload my image". Full control over pricing is provided by the Spree calculator mechanism.

## Version Notes

The branch 4-6-stable version for spree >=4.6.0

## Installation

### See the notes in Versionfile if you are using an older version of spree


`gem 'spree_flexi_variants', github: 'rahul2103/spree_flexi_variants', branch: '4-6-stable'`

`bundle install`

`bundle exec rails g spree_flexi_variants:install`

# Storefront Flexi Product API Documentation

## Included Data

When querying the Storefront Products API, the response includes an "Included" section with additional data related to the main product. This section provides details on various entities that complement the core product information.

```ruby
{{baseUrl}}api/v2/storefront/products/:product_slug?include=ad_hoc_option_types,product_customization_types,ad_hoc_variant_exclusions
```

### Ad-hoc Option Type

Represents dynamic, user-defined product options that can significantly impact the pricing and customization of the product. Each ad-hoc option type may have multiple values, providing users with diverse choices for personalization.

```ruby
{{baseUrl}}api/v2/storefront/products/:product_slug?include=ad_hoc_option_types
```

- **price_modifier_type** (string|null): Specifies the type of price modifier applied to the product, such as a fixed amount or a percentage.
- **is_required** (boolean): Indicates whether the option is required for the product. If true, users must select a value for this option during customization.
- **position** (integer): Represents the order or priority of the option type in the product configuration.
- **option_type** (object): Contains detailed information about the option type, including its ID, name, presentation, and other attributes.
- **ad_hoc_option_values** (array): An array of ad-hoc option values, each providing specific details:
  - **id** (integer): The unique identifier for the option value.
  - **price_modifier** (string): The price modification associated with the option value.
  - **selected** (boolean): Indicates whether the option value is selected.
  - ... (Other attributes)

#### Sample Response

```json
  {
      "id": "4",
      "type": "ad_hoc_option_type",
      "attributes": {
          "price_modifier_type": null,
          "is_required": false,
          "position": 1,
          "option_type": {
              "id": 1,
              "name": "Sprinkles",
              "presentation": "Sprinkles",
              "position": 1,
              "created_at": "2024-01-25T17:58:45.337Z",
              "updated_at": "2024-01-25T18:01:36.921Z",
              "filterable": true,
              "public_metadata": {},
              "private_metadata": {},
              "preferences": null
          },
          "ad_hoc_option_values": [
              {
                  "id": 15,
                  "ad_hoc_option_type_id": 4,
                  "option_value_id": 1,
                  "price_modifier": "450.0",
                  "created_at": "2024-02-01T10:31:22.795Z",
                  "updated_at": "2024-02-01T10:33:39.899Z",
                  "position": 1,
                  "selected": false,
                  "cost_price_modifier": null,
                  "preferences": null
              },
              {
                  "id": 16,
                  "ad_hoc_option_type_id": 4,
                  "option_value_id": 2,
                  "price_modifier": "50.0",
                  "created_at": "2024-02-01T10:31:28.167Z",
                  "updated_at": "2024-02-01T10:31:42.094Z",
                  "position": 2,
                  "selected": false,
                  "cost_price_modifier": null,
                  "preferences": null
              }
          ]
      }
  },
  {
      "id": "7",
      "type": "ad_hoc_option_type",
      "attributes": {
          "price_modifier_type": null,
          "is_required": false,
          "position": 2,
          "option_type": {
              "id": 2,
              "name": "Icing",
              "presentation": "Icing",
              "position": 2,
              "created_at": "2024-01-25T18:00:00.406Z",
              "updated_at": "2024-01-25T18:02:02.604Z",
              "filterable": true,
              "public_metadata": {},
              "private_metadata": {},
              "preferences": null
          },
          "ad_hoc_option_values": [
              {
                  "id": 19,
                  "ad_hoc_option_type_id": 7,
                  "option_value_id": 3,
                  "price_modifier": "30.0",
                  "created_at": "2024-02-01T17:49:55.164Z",
                  "updated_at": "2024-02-01T17:50:08.832Z",
                  "position": 1,
                  "selected": false,
                  "cost_price_modifier": "50.0",
                  "preferences": null
              }
          ]
      }
  }
```

### Product Customization Type

Describes customization options available for the product, enabling users to tailor specific aspects according to their preferences. Product customization types typically involve calculators that determine the pricing based on user selections.

```ruby
{{baseUrl}}api/v2/storefront/products/:product_slug?include=product_customization_types
```

- **calculator** (string): Identifies the calculation method for customization pricing, such as "Spree::Calculator::AmountTimesConstant."
- **customizable_product_options** (array): An array of customizable product options, each providing details:
- **id** (integer): The unique identifier for the customization option.
- **position** (integer): Represents the order or priority of the customization option in the product configuration.
- **presentation** (string): The user-friendly label for the customization option.
- **name** (string): The internal name of the customization option.
- **description** (string): Additional information or instructions for the customization option.
- **...** (Other attributes)

```json
  {
      "id": "1",
      "type": "product_customization_type",
      "attributes": {
          "calculator": "Spree::Calculator::AmountTimesConstant",
          "customizable_product_options": [
              {
                  "id": 1,
                  "product_customization_type_id": 1,
                  "position": null,
                  "presentation": "How many?",
                  "name": "amount",
                  "description": "How many?",
                  "created_at": "2024-01-25T17:51:29.216Z",
                  "updated_at": "2024-01-25T17:53:19.506Z",
                  "preferences": null
              }
          ]
      }
  },
  {
      "id": "2",
      "type": "product_customization_type",
      "attributes": {
          "calculator": "Spree::Calculator::Engraving",
          "customizable_product_options": [
              {
                  "id": 2,
                  "product_customization_type_id": 2,
                  "position": null,
                  "presentation": "Message",
                  "name": "inscription",
                  "description": "Message",
                  "created_at": "2024-01-25T17:55:58.885Z",
                  "updated_at": "2024-01-25T17:56:33.174Z",
                  "preferences": null
              }
          ]
      }
  },
  {
      "id": "3",
      "type": "product_customization_type",
      "attributes": {
          "calculator": "Spree::Calculator::ProductArea",
          "customizable_product_options": [
              {
                  "id": 3,
                  "product_customization_type_id": 3,
                  "position": null,
                  "presentation": "Width",
                  "name": "width",
                  "description": "Width",
                  "created_at": "2024-02-02T10:29:47.547Z",
                  "updated_at": "2024-02-02T10:38:00.769Z",
                  "preferences": null
              },
              {
                  "id": 4,
                  "product_customization_type_id": 3,
                  "position": null,
                  "presentation": "Height",
                  "name": "height",
                  "description": "Height",
                  "created_at": "2024-02-02T10:29:47.550Z",
                  "updated_at": "2024-02-02T10:38:00.771Z",
                  "preferences": null
              }
          ]
      }
  }
```

### Ad-hoc Variant Exclusions

Defines exclusions or restrictions on certain ad-hoc option values for specific product variants, ensuring compatibility and preventing conflicting customizations.

```ruby
{{baseUrl}}api/v2/storefront/products/:product_slug?include=ad_hoc_variant_exclusions
```

- **excluded_ad_hoc_option_values** (array): An array specifying ad-hoc option values that are excluded from particular product variants. Each exclusion contains details:
- **id** (integer): The unique identifier for the exclusion.
- **ad_hoc_option_value_id** (integer): The ID of the excluded ad-hoc option value.
- **preferences** (object): Additional preferences or metadata related to the exclusion.
- **...** (Other attributes)

```json
  {
      "id": "3",
      "type": "ad_hoc_variant_exclusions",
      "attributes": {
          "excluded_ad_hoc_option_values": [
              {
                  "id": 5,
                  "ad_hoc_variant_exclusion_id": 3,
                  "ad_hoc_option_value_id": 15,
                  "preferences": null
              },
              {
                  "id": 6,
                  "ad_hoc_variant_exclusion_id": 3,
                  "ad_hoc_option_value_id": 19,
                  "preferences": null
              }
          ]
      }
  },
  {
      "id": "4",
      "type": "ad_hoc_variant_exclusions",
      "attributes": {
          "excluded_ad_hoc_option_values": [
              {
                  "id": 7,
                  "ad_hoc_variant_exclusion_id": 4,
                  "ad_hoc_option_value_id": 16,
                  "preferences": null
              },
              {
                  "id": 8,
                  "ad_hoc_variant_exclusion_id": 4,
                  "ad_hoc_option_value_id": 19,
                  "preferences": null
              }
          ]
      }
  }
```

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2024 spree_flexi_variants, released under the New BSD License

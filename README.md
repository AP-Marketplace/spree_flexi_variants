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

## Examples

Build a 'Cake' product using **Ad Hoc Options** and **Product Customizations**


https://github.com/rahul2103/spree_flexi_variants/assets/81744029/6e4d89de-e677-4867-95eb-d58f15b36ba5

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2024 spree_flexi_variants, released under the New BSD License

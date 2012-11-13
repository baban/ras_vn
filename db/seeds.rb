# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
require 'active_record/fixtures'

Flextures::Config.fixture_load_directory = "db/seeds/"

# seedをロード
def load_table(filename, klass)
  klass.delete_all
  fn = "#{Rails.root}/db/seeds/#{filename}.csv"
  CSV.open( fn ) do |csv|
    keys = csv.shift
    csv.each do |values|
      h = values.extend(Flextures::Extensions::Array).to_hash(keys)
      o = klass.new
      h.each{ |k,v|
        v && v.force_encoding("UTF-8")
        o[k]=v
      }
      o.save
    end
  end
end

{
  distincts: Distinct,
  prefectures: Prefecture,
  tpl_sets: TplSet,
  recipe_food_genres: RecipeFoodGenre,
  recipe_foods: RecipeFood
}.each do |filename,klass|
  puts "#{filename} reading..."
  load_table(filename,klass)
end


# encoding: utf-8

class RecipeViewLog
  include Mongoid::Document

  field :recipe_id,   type: Integer
  field :user_id,     type: Integer
  field :sex,         type: Integer
  field :age,         type: Integer
  field :distinct_id, type: Integer
end

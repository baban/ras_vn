# encoding: utf-8

class RecipeStepDraft < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe_draft

  mount_uploader :image, RecipeStepsUploader

  def self.post_filter( form_values )
    form_values.select{ |o| o[:content].present? }.map { |v| RecipeStepDraft.new(v) }
  end
end

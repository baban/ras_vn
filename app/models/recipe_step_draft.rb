# encoding: utf-8

class RecipeStepDraft < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe_draft

  mount_uploader :image, RecipeStepsUploader

  # generate new recipe steps data
  #
  # @params [Array] last_steps last edited steps data
  # @return [Array] new recipe steps
  def self.post_filter( form_values, last_steps )
    form_values.select{ |o| o[:content].present? }.map { |v| RecipeStepDraft.new(v) }
  end
end

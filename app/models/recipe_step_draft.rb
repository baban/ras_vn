# encoding: utf-8

class RecipeStepDraft < ActiveRecord::Base
  acts_as_paranoid

  validates :content,         length: { maximum: 800 }
  belongs_to :recipe_draft

  mount_uploader :image, RecipeStepsUploader

  # generate new recipe steps data
  #
  # @params [Array] last_steps last edited steps data
  # @return [Array] new recipe steps
  def self.post_filter( form_values, last_steps )
    # last_steps is referensed to success last_step.image
    last_steps = last_steps[0..form_values.size].push( *[nil]*[(form_values.size-last_steps.size),0].max )
    form_values = [form_values,last_steps].transpose
    steps= form_values.select do |o|
      draft = o.first
      draft[:content].present? or draft[:image].present? or draft[:movie_url].present?
    end.map do |params,last_step|
      d = RecipeStepDraft.new(params)
      d.image= File.open(last_step.image.current_path) if d.image.blank? and last_step.try(:image).present? and File.exist?(last_step.image.current_path)
      # movie and image cannot upload both files
      d.movie_url = "" if d.image.current_path
      Rails.logger.info d.inspect
      d
    end
    steps
  end
end

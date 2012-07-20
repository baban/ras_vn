# encoding: utf-8
require 'spec_helper'

describe NotesHelper do
  describe "#board_placeholder" do
    let(:user) { build(:user) }
    subject { helper.board_placeholder(user) }

    it "文字列を返すこと" do
      should be_an_instance_of String 
    end 
  end
end

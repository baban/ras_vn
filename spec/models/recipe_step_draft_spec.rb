# encoding: utf-8

require 'spec_helper'

describe RecipeStepDraft do
  describe "post_filter" do
    context "blank values" do
      let(:prms) do
        h = {
          recipe_steps: [
            {"movie_url"=>"", "content"=>""},
            {"movie_url"=>"", "content"=>""},
            {"movie_url"=>"", "content"=>""},
            {"movie_url"=>"", "content"=>""},
          ]
        }
        ActiveSupport::HashWithIndifferentAccess.new(h)
      end

      let(:prms2) do
        h = {
          recipe_steps: [
            { movie_url: "", content: "かぼちゃは、種を取り除き洗う。\r\n\r\nビニール袋に入れて、竹串がスッと通るぐらいまで加熱する。　\r\n"},
            { movie_url: "", content: "食べやすい大きさにカットする。\r\n\r\nお好みの形でどうぞ～\r\n"},
            { movie_url: "", content: "" },
            { movie_url: "", content: "" },
          ]
        }
        ActiveSupport::HashWithIndifferentAccess.new(h)
      end

      before do
        @last_steps = prms2[:recipe_steps].map{ |o| RecipeStepDraft.new(o)  }
        @steps = RecipeStepDraft.post_filter( prms[:recipe_steps], @last_steps )
      end
      it "不正な値は全てからになる" do
        @steps.should == []
      end
    end

    context "blank values" do
      let(:prms) do
        h = {
          recipe_steps: [
            { movie_url: "", content: "かぼちゃは、種を取り除き洗う。\r\n\r\nビニール袋に入れて、竹串がスッと通るぐらいまで加熱する。　\r\n"},
            { movie_url: "", content: "食べやすい大きさにカットする。\r\n\r\nお好みの形でどうぞ～\r\n"},
            { movie_url: "", content: "" },
            { movie_url: "", content: "" },
          ]
        }
        ActiveSupport::HashWithIndifferentAccess.new(h)
      end
      let(:prms2) do
        h = {
          recipe_steps: [
            { movie_url: "", content: "かぼちゃは、種を取り除き洗う。\r\n\r\nビニール袋に入れて、竹串がスッと通るぐらいまで加熱する。　\r\n"},
            { movie_url: "", content: "食べやすい大きさにカットする。\r\n\r\nお好みの形でどうぞ～\r\n"},
            { movie_url: "", content: "" },
            { movie_url: "", content: "" },
          ]
        }
        ActiveSupport::HashWithIndifferentAccess.new(h)
      end
      before do
        @last_steps = prms2[:recipe_steps].map{ |o| RecipeStepDraft.new(o)  }
        @steps = RecipeStepDraft.post_filter( prms[:recipe_steps], @last_steps )
      end
      it "不正な値は全てからになる" do
        @steps.size.should == 2
      end
    end
    context "" do
      before do
      end
      it "" do
      end
    end
  end
end

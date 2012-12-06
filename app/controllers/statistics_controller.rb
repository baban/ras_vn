# encoding: utf-8

class StatisticsController < Admin::BaseController
  helper :html5jp_graphs

  def index
  end

  def users
    @user_total = UserProfile.count

    @sex_rate_graph = create_profile_table
    @prefecture_table = create_prefecture_table
    @dicade_table = create_dicade_table
    @food_genre_table = create_recipe_food_genre_table
    @foodstuff_table = create_recipe_food_table
  end

  def access
  end

  def access_source
    h = {
      nodes:[
             { label: "/", amount: 546 },
             { label: "/mypage", amount: 300 },
             { label: "/columns", amount: 150 },
             { label: "/user_reports", amount: 10 },
             { label: "/questions", amount: 10 },
             { label: "/navi_questions", amount: 10 },
             { label: "/free", amount: 10 },
             { label: "/charge", amount: 10 },
             { label: "/errors", amount: 10 },
             { label: "/answers", amount: 10 },
            ],
      links: [
              { source: 0, target: 1, weight: 0.5, amount: 100 },
              { source: 0, target: 4, weight: 0.5, amount: 10 },
              { source: 0, target: 3, weight: 0.5, amount: 150 },
              { source: 0, target: 2, weight: 0.5, amount: 200 },
              { source: 4, target: 5, weight: 0.5, amount: 300 },
              { source: 4, target: 9, weight: 0.5, amount: 10 },
              { source: 5, target: 9, weight: 0.5, amount: 10 },
              { source: 1, target: 4, weight: 0.5, amount: 10 },
              { source: 1, target: 5, weight: 0.5, amount: 10 },
              { source: 0, target: 6, weight: 0.5, amount: 10 },
              { source: 0, target: 7, weight: 0.5, amount: 10 },
              { source: 8, target: 9, weight: 0.5, amount: 10 },
             ]
    }

    h = FluentLog.aggrigation

    respond_to do |format|
      format.json { render json: h }
      format.html { render json: h }
    end
  end

  def profile
    @prefecture_amount_greph = UserProfile.group(:prefecture_id).count
    # @age_amount_greph = UserProfile.group(:prefecture_id).count
  end

  private

  def create_profile_table
    sex_label = ["その他","男性","女性"]
    UserProfile.group(:sex).count.map{ |k,v| [sex_label[k],v] }
  end

  def create_prefecture_table
    h = Prefecture.all.inject({}){ |h,o| h[o.id]=o.name; h }
    profiles = UserProfile.group(:sex).count
    pref_names = profiles.keys.map{ |v| h[v].to_s }
    values = profiles.values

    [pref_names,values].transpose
  end

  def create_dicade_table
    profiles = UserProfile.find_by_sql(["select (t.birthday*10) as birthday, count(*) as sex from (select round(((curdate()+0)-(birthday + 0))/100000) as birthday from user_profiles) as t group by birthday;"])
    profiles.map { |o| [o.birthday.to_i, o.sex] }
  end

  def create_recipe_food_genre_table
    RecipeFoodGenre.all.map { |o| [o.name,o.amount] }
  end

  def create_recipe_food_table
    RecipeFoodstuff.group(:name).count.map{ |k,v| [k,v] }.sort { |a,b| b[1]<=>a[1] }[0..10]
  end
end


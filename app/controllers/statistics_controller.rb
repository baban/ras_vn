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
    pref_names = ["県名"].concat( profiles.keys.map{ |v| h[v].to_s } )
    params = { x: pref_names, y:["人数"], canvas_id:"prefecture_graph" }
    values = ["県"].concat(profiles.values)

    [values,params]
  end

  def create_dicade_table
    profiles = UserProfile.find_by_sql(["select (t.birthday*10) as birthday, count(*) as sex from (select round(((curdate()+0)-(birthday + 0))/100000) as birthday from user_profiles) as t group by birthday;"])
    keys, values = profiles.map { |o| [o.birthday.to_i, o.sex] }.transpose

    params = { x: ["年代"].concat(keys), y:["人数"], canvas_id:"dicade_graph" }
    values = ["会員数"].concat(values)

    [values,params]
  end
end

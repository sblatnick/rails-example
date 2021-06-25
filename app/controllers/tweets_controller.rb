class TweetsController < ApplicationController
  def index
    @tweets = Tweet
      .where('text like ?', '%space%')
      .select("(CASE WHEN text LIKE '%Branson%' THEN 1 ELSE 0 END) AS cnt, name, text")
      .order('cnt DESC')
  end
end

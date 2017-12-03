class BillboardsController < ApplicationController
  before_action :authenticate_user!

  def index

    # Old and busted
    # @billboards = Billboard.all.order("score desc")


    # Much more sexy:

    # Score = (P-1) / (T+2)^G
    #
    # where
    # P = points of an item (and -1 is to negate submitters vote)
    # T = time since submission (in hours)
    # G = Gravity, defaults to 1.8 in news.arc

    billboards = Billboard.all
    weighted_billboards = {}
    billboards.each do |b|
      billboard = {}
      billboard[:id] = b.id
      billboard[:name] = b.name
      billboard[:image] = b.image
      billboard[:score] = b.score
      t = ((Time.now - b.created_at) / 1.hour).round
      billboard[:weighted_score] = (b.score - 1) / (t + 2)**1.8
      weighted_billboards[billboard[:weighted_score]] = billboard
    end

    billboards = weighted_billboards.sort_by{|k, _| k}.reverse.to_h
    @billboards = []
    billboards.each {|k, v| @billboards.push v}

  end
end

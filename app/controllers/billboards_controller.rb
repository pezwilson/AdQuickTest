class BillboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    billboards = Billboard.all
    weighted_billboards = []
    billboards.each do |b|
      billboard = {}
      billboard[:id] = b.id
      billboard[:name] = b.name
      billboard[:image] = b.image
      billboard[:score] = b.score
      t = ((Time.now - b.created_at) / 1.hour).round
      billboard[:weighted_score] = b.score / (t + 2)**1.8
      weighted_billboards.push billboard
    end
    @billboards = weighted_billboards.sort_by { |hsh| hsh[:weighted_score] }.reverse
  end
end

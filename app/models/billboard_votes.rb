class BillboardVote < ApplicationRecord
  belongs_to :billboard
  belongs_to :user

  enum direction: [ :up, :down]
end
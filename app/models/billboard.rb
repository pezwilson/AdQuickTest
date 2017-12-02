class Billboard < ApplicationRecord
  has_many :billboard_votes

  validates :name, :image, presence: true

end

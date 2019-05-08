class Word < ApplicationRecord
  validates_uniqueness_of :text
end

class Facilitate < ApplicationRecord
  include OrderAble
  belongs_to :facilitate_taxon, autosave: true, counter_cache: true
  has_many :products
  has_many :facilitate_providers
  has_many :providers, through: :facilitate_providers
  has_one :facilitate_provider, -> { where(selected: true) }
  has_one :provider, through: :facilitate_provider

  has_one_attached :logo

  attribute :quantity, :integer, default: 1
  attribute :unified_quantity, :integer, default: 1
  attribute :unit, :string, default: '个'


end
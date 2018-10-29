class Provider < ApplicationRecord
  belongs_to :area, optional: true
  has_many :users, inverse_of: :provider
  has_many :part_providers
  has_many :parts, through: :part_providers
  has_many :facilitate_providers
  has_many :facilitates, through: :facilitate_providers

  def name_detail
    "#{name} (#{id})"
  end

  has_one_attached :logo

end unless RailsFactory.config.disabled_models.include?('Provider')




=begin

create_table "providers", force: :cascade do |t|
  t.string   "name",        limit: 255
  t.string   "address",     limit: 255
  t.integer  "area_id",     limit: 4
  t.datetime "created_at",              null: false
  t.datetime "updated_at",              null: false
  t.string   "service_tel", limit: 255
  t.string   "service_qq",  limit: 255
end

=end

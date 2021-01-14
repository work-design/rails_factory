module Factory
  module Model::Produce
    extend ActiveSupport::Concern

    included do
      has_many :good_produces
      has_one_attached :logo
    end

  end
end

=begin

# 生产工艺

t.string   "product",    limit: 255
t.string   "name",       limit: 255
t.text     "content",    limit: 65535
t.datetime "start_at"
t.datetime "finish_at"
t.datetime "created_at"
t.datetime "updated_at"

=end

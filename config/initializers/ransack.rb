Ransack.configure do |config|
  config.add_predicate 'date_equals',
                       arel_predicate: 'eq',
                       formatter: proc { |v| Chronic.parse(v).to_date rescue nil },
                       validator: proc { |v| v.present? },
                       type: :string
end
class OfficerExport
  extend TheData::Export

  config do
    collect -> (params){ Officer.default_where(params) }
    column :name, header: 'Name', field: -> (o){ o.name }
    column :count, header: 'Office', field: -> (o){ o.office&.name }
    column :people, header: 'Department', field: -> (o){ o.department&.root&.name }
    column :parent, header: 'Supervisor', field: -> (o){ o.parent&.name }
  end

end

class DepartmentExport
  extend TheData::Export

  config do
    collect -> (params){ Department.default_where(params) }
    column :name, header: 'Department', field: -> (o){ ' ' * o.depth + o.name.to_s }
    column :offices, header: 'Offices', field: -> (o){ o.offices.pluck(:name).join(',') }
    column :leader, header: 'Leader', field: -> (o){ o.leader&.name }
    column :editorial, header: 'Section Editorial Director', field: -> (o){ o.editorial&.name }
    column :marketing, header: 'Marketing Assistant', field: -> (o){ o.marketing&.name }
    column :hr, header: 'Section Hr', field: -> (o){ o.hr&.name }
    column :financial, header: 'Financial Assistant', field: -> (o){ o.financial&.name }
    column :layout, header: 'Layout Group Leader', field: -> (o){ o.layout&.name }
  end

end

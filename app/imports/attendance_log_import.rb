module AttendanceLogImport
  extend TheData::Import

  config do
    model AttendanceLog
    column :name, header: '姓名'
    column :number, header: '考勤号码'
    column :record_at, header: '日期时间'
  end

end

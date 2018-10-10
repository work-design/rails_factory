function timeForLocalized(){
  $('time[data-localized!="true"]').each(function(){
    this.textContent = moment.utc(this.textContent).local().format('YYYY-MM-DD HH:mm');
    this.dataset['localized'] = 'true'
  })
}
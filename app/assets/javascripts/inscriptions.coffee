

$.fn.random = () ->
  ret = $()
  if this.length > 0
    ret = ret.add(this[Math.floor((Math.random() * this.length))])
    return ret

showAppointedAt = () ->
  # check if we're on appointment form
  if $('#js-appointed-at-day').length > 0
    if $('#js-appointed-at-day').html().length == 0
      # if it's a new appointmnet
      $('.audiencia .nav li a').random().trigger('click')
      $('#inscription_appointed_at_input:visible a').random().trigger('click')
      console.log('new')
    else
      # if there is an already filled up appointment 
      day = $('#js-appointed-at-day').html()
      hour = $('#js-appointed-at-hour').html()
      # activate day
      $("a[href='##{day}']").trigger('click')
      # activate hour
      $('#inscription_appointed_at_input a').removeClass('active')
      $("a[data-value='#{hour}']").trigger('click')

showOffice = () ->
  if $('.js-office-show').length > 0
    changeOffice($('.js-office-show'))
    $('.js-office-show').on 'change', ->
      changeOffice($(this))

changeOffice = ($el) ->
  if $el.val() == "No"
    $('.js-office-show-wrapper').hide('slow')
  else
    $('.js-office-show-wrapper').show('slow').removeClass('hide')


locationCascadeSelect = (parent, child) ->
  # http://snipplr.com/view/26338/cascading-select-boxes/
  childOptions = child.find('option:not(.static)')
  child.data 'options', childOptions
  parent.change ->
    childOptions.remove()
    child.append(child.data('options').filter('.sub_' + this.value)).change()
  childOptions.not('.static, .sub_' + parent.val()).remove()


locationCascadeSelectWrapper = () ->
  # show / hide based on classes and data-value attributes
  # view app/views/inscriptions/_form_audiencia.html.erb
  cascadeForm = $('.formtastic')
  provSelect = cascadeForm.find('#inscription_provincia')
  cantonSelect = cascadeForm.find('#inscription_canton')
  parroquiaSelect = cascadeForm.find('#inscription_parroquia')
  repprovSelect = cascadeForm.find('#inscription_rep_provincia')
  repcantonSelect = cascadeForm.find('#inscription_rep_canton')
  repparroquiaSelect = cascadeForm.find('#inscription_rep_parroquia')

  locationCascadeSelect provSelect, cantonSelect
  locationCascadeSelect cantonSelect, parroquiaSelect
  locationCascadeSelect repprovSelect, repcantonSelect
  locationCascadeSelect repcantonSelect, repparroquiaSelect

  if $('#inscription_provincia').val() == ""
    $('#inscription_provincia').find('option').removeAttr('selected')
    $('#inscription_provincia').find('option[value="c_insprovincia_4"]').prop("selected", true)
    $('#inscription_provincia').change()

    $('#inscription_canton').find('option').removeAttr('selected')
    $('#inscription_canton').find('option[value="c_inscanton_4_1"]').prop("selected", true)
    $('#inscription_canton').change()

    $('#inscription_parroquia').find('option').removeAttr('selected')
    $('#inscription_parroquia').find('option[value="c_insparroquia_4_1_50"]').prop("selected", true)

  if $('#inscription_rep_provincia').val() == ""
    $('#inscription_rep_provincia').find('option').removeAttr('selected')
    $('#inscription_rep_provincia').find('option[value="c_repprovincia_4"]').prop("selected", true)
    $('#inscription_rep_provincia').change()

    $('#inscription_rep_canton').find('option').removeAttr('selected')
    $('#inscription_rep_canton').find('option[value="c_repcanton_4_1"]').prop("selected", true)
    $('#inscription_rep_canton').change()

    $('#inscription_rep_parroquia').find('option').removeAttr('selected')
    $('#inscription_rep_parroquia').find('option[value="c_repparroquia_4_1_50"]').prop("selected", true)

$ ->
  showAppointedAt()
  showOffice()
  locationCascadeSelectWrapper()
  if $('.js-modal').length > 0
    $('.js-modal').modal('show')


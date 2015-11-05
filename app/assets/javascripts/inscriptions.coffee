

# jquery function: get a random element
$.fn.random = () ->
  ret = $()
  if this.length > 0
    ret = ret.add(this[Math.floor((Math.random() * this.length))])
    return ret

# appointments on /solicitar/peticion-de-audiencia-con-el-prefecto
# when there is an old appointment, if it's a new or if it's already filled up
showAppointedAt = () ->
  # check if we're on appointment form
  if $('#js-appointed-at-day').length > 0
    if $('#js-appointed-at-day').html().length == 0
      # if it's a new appointmnet
      $('.audiencia .nav li a').random().trigger('click')
      $('#inscription_appointed_at_input:visible a').random().trigger('click')
      $('.tab-pane:hidden list-group-item').removeClass('active')
    else
      # if there is an already filled up appointment 
      day = $('#js-appointed-at-day').html()
      hour = $('#js-appointed-at-hour').html()
      # activate day
      $("a[href='##{day}']").trigger('click')
      # activate hour
      $('#inscription_appointed_at_input a').removeClass('active')
      $("a[data-value='#{hour}']").trigger('click')

# appointments on /solicitar/peticion-de-audiencia-con-el-prefecto
# no available appointments
showNoAvailableAppointemnts = () ->
  if $('.js-appointed-at-availability').length > 0
    $('.tab-pane').each( ->
      $tab = $(this)
      if $tab.find('.list-group a').length == 0
        msg = '<div class="alert alert-info"><b>Lo sentimos</b> El prefecto no tiene ningún horario disponible para este día</div>'
        $tab.html(msg)
    )


# do you have an office? ¿tiene ingresado oficio? on /solicitar/peticion-de-audiencia-con-el-prefecto
showOffice = () ->
  if $('.js-office-show').length > 0
    changeOffice($('.js-office-show'))
    $('.js-office-show').on 'change', ->
      changeOffice($(this))

# do you have an office? ¿tiene ingresado oficio? on /solicitar/peticion-de-audiencia-con-el-prefecto
changeOffice = ($el) ->
  if $el.val() == "No"
    $('.js-office-show-wrapper').hide('slow')
  else
    $('.js-office-show-wrapper').show('slow').removeClass('hide')

# appointments on /solicitar/peticion-de-audiencia-con-el-prefecto
# put active tab-pane on last position, to save that on the form POST
movePaneToLast = () ->
  content = $('.tab-pane.active')[0].outerHTML
  $('.tab-pane.active').remove()
  $('.tab-content').append(content)
  $('.select').listgroup()


# location select with subcategories, for Provincia / Cantón / Parroquias selects
locationCascadeSelect = (parent, child) ->
  # http://snipplr.com/view/26338/cascading-select-boxes/
  childOptions = child.find('option:not(.static)')
  child.data 'options', childOptions
  parent.change ->
    childOptions.remove()
    child.append(child.data('options').filter('.sub_' + this.value)).change()
  childOptions.not('.static, .sub_' + parent.val()).remove()


# location select with subcategories, for Provincia / Cantón / Parroquias selects
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
  showNoAvailableAppointemnts()
  showOffice()

  # activate selects 
  if $('.formtastic').length > 0
    locationCascadeSelectWrapper()

  # show pretty modals
  if $('.js-modal').length > 0
    $('.js-modal').modal('show')

  # save form for for later 
  if $('#new_inscription').length > 0
    $('.js-phoenix').phoenix()
    $('.js-phoenix').phoenix('load')
    $('#new_inscription').on('submit', ->
      if $('.js-save-data').is(":checked")
        $('.js-phoenix').phoenix('save')
      else
        $('.js-phoenix').phoenix('remove')
    )

  # move last active  pane to last
  if $('.tab-pane').length > 0
    movePaneToLast()

  $('a[data-toggle="tab"]').on 'shown.bs.tab', ->
    #$('.tab-pane:hidden .list-group-item').removeClass('active')
    #$('#inscription_appointed_at_input:visible a').random().trigger('click')
    console.log('change')
    movePaneToLast()



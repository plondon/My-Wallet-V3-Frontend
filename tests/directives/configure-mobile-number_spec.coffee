describe "Change Mobile Number Directive", ->
  $compile = undefined
  $rootScope = undefined
  element = undefined
  isoScope = undefined

  beforeEach module("walletApp")

  beforeEach inject((_$compile_, _$rootScope_, Wallet) ->

    $compile = _$compile_
    $rootScope = _$rootScope_

    Wallet.user = {mobile: {number: "12345678", country: "31"}}

    # bc-mobile-number formats the number:
    Wallet.user.internationalMobileNumber = "+31 12345678"

    return
  )

  beforeEach ->
    element = $compile("<configure-mobile-number></configure-mobile-number>")($rootScope)
    $rootScope.$digest()
    isoScope = element.isolateScope()
    isoScope.$digest()

    # bc-mobile-number formats the number:
    isoScope.fields.newMobile = "+31 12345678"


  it "should have text", ->
    expect(element.html()).toContain "SAVE"

  it "should not spontaniously save", inject((Wallet) ->
    spyOn(Wallet, "changeMobile")
    expect(Wallet.changeMobile).not.toHaveBeenCalled()

    return
  )

  it "should let user change it", inject((Wallet) ->
    spyOn(Wallet, "changeMobile")

    isoScope.changeMobile("+3100000000")

    expect(Wallet.changeMobile).toHaveBeenCalled()

    return
  )

  it "should not allow reusing the previous number", ->
    isoScope.fields.newMobile = "+31 12345678"
    expect(isoScope.numberChanged()).toBe(false)
    return

  return

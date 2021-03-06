describe "SettingsSecurityCenterCtrl", ->
  scope = undefined
  Wallet = undefined

  beforeEach angular.mock.module("walletApp")

  beforeEach ->
    angular.mock.inject ($injector, $rootScope, $controller) ->
      Wallet = $injector.get("Wallet")

      Wallet.user = {
        internationalMobileNumber: "+1234567890"
      }

      scope = $rootScope.$new()

      $controller "SettingsSecurityCenterCtrl",
        $scope: scope,
        $stateParams: {},

      scope.$digest()

      return

    return

  it "should have wallet settings", inject((Wallet) ->
    expect(scope.settings).toBe(Wallet.settings)
  )

  it "should have wallet user", inject((Wallet) ->
    expect(scope.user).toBe(Wallet.user)
  )

  it "should have wallet status", inject((Wallet) ->
    expect(scope.status).toBe(Wallet.status)
  )

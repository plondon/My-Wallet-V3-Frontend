walletApp.controller "RecoveryCtrl", ($scope, Wallet, $state, $translate) ->
  $scope.recoveryPhrase = null
  $scope.recoveryPassphrase = null
  $scope.showRecoveryPhrase = false
  $scope.editMnemonic = false
  $scope.status = Wallet.status

  $scope.isValidMnemonic = Wallet.isValidBIP39Mnemonic

  $scope.toggleRecoveryPhrase = () ->
    if !$scope.showRecoveryPhrase
      success = (mnemonic, passphrase) ->
        $scope.recoveryPhrase = mnemonic
        $scope.recoveryPassphrase = passphrase
        $scope.showRecoveryPhrase = true
        
      error = (message) ->
        
      Wallet.getMnemonic(success, error)
    else
      $scope.recoveryPhrase = null
      $scope.recoveryPassphrase = null
      $scope.showRecoveryPhrase = false

  $scope.doNotCopyPaste = (event) ->
    event.preventDefault()
    $translate("DO_NOT_COPY_PASTE").then (translation) ->
      Wallet.displayWarning translation

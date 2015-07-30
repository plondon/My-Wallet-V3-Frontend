walletApp.controller "RecoverCtrl", ($scope, $log, Wallet, $translate, $cookieStore, $state) ->
  $scope.fields = {mnemonic: "", password: "", confirmation: ""}
  $scope.errors = {mnemonic: null, password: null, confirmation: null}
  $scope.success =  {mnemonic: null, password: null, confirmation: null}
  $scope.working = false
  $scope.isValidMnemonic = Wallet.isValidBIP39Mnemonic
  
  $scope.recover = () ->
    $scope.working = true
    
    success = (uid) ->
      $scope.working = false
      $cookieStore.put("uid", uid)
      $state.go("wallet.common.dashboard")
      
    error = () ->
      $scope.working = false
    
    Wallet.recover($scope.fields.mnemonic, $scope.fields.password, success, error)
    
  $scope.validate = (visual=true) ->
    $scope.isValid = true
    
    if $scope.form 
      if $scope.isValidMnemonic($scope.fields.mnemonic)
        $scope.success.mnemonic = true
      else
        $scope.isValid = false
        $translate("INVALID_RECOVERY").then (translation) ->
          $scope.errors.mnemonic =  translation
          
    if $scope.fields.password == ""
      $scope.isValid = false
      return
          
    if $scope.form && $scope.form.$error     
      if $scope.form.$error.minEntropy
        $scope.isValid = false
        $translate("TOO_WEAK").then (translation) ->
          $scope.errors.password =  translation
      if $scope.form.$error.maxlength
        $scope.isValid = false
        $translate("TOO_LONG").then (translation) ->
          $scope.errors.password =  translation
          
    if $scope.fields.confirmation == ""
      $scope.isValid = false
    else
      if $scope.fields.confirmation == $scope.fields.password
        $scope.success.confirmation = true
      else
        $scope.isValid = false
        if visual
          $translate("NO_MATCH").then (translation) ->
            $scope.errors.confirmation = translation
    
angular
  .module('walletApp')
  .controller('RecoverFundsCtrl', RecoverFundsCtrl);

function RecoverFundsCtrl($scope, $rootScope, $state, $timeout, Wallet) {
  $scope.isValidMnemonic = Wallet.isValidBIP39Mnemonic;
  $scope.currentStep = 1;
  $scope.fields = {
    email: '',
    password: '',
    confirmation: '',
    mnemonic: '',
    bip39phrase: ''
  };

  $scope.recover = () => {
    $scope.working = true;

    const success = (uid) => {
      
      const didLoginFinished = () => {
        $rootScope.beta = false;
        $scope.working = false;
        $scope.nextStep();
        
        $rootScope.$safeApply();
      
        $timeout(() => {
          $state.go("wallet.common.home");
          Wallet.displaySuccess('Successfully recovered wallet!');
        }, 4000);
        
      }
      
      Wallet.didLogin(uid, didLoginFinished);
 
    };

    const error = (message) => {
      $scope.working = false;
      Wallet.displayError(message);
    };

    Wallet.my.recoverResetPasswordAndLogin($scope.fields.mnemonic, "", $scope.fields.email, $scope.fields.password, success, error);
  };

  $scope.nextStep = () => {
    $scope.currentStep++;
  };

  $scope.goBack = () => {
    $scope.currentStep--;
  };

}

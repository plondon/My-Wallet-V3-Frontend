angular
  .module('walletApp')
  .controller("FirstTimeCtrl", FirstTimeCtrl);

function FirstTimeCtrl($scope, $timeout, $uibModalInstance, firstTime) {
  $scope.firstTime = firstTime;
  $scope.ok = () => {
  	$uibModalInstance.close(firstTime);
  }

  $scope.rocket = {
    finished: false,
    launching: false
  }

  $timeout(() => {
    $scope.rocket.launching = true;
  }, 4780)

  $timeout(() => {
    $scope.rocket.finished = true;
  }, 6040)
}

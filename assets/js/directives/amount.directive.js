
angular
  .module('walletApp')
  .directive('amount', amount);

amount.$inject = ['Wallet', 'currency'];

function amount(Wallet, currency) {
  const directive = {
    restrict: 'E',
    replace: 'false',
    scope: {
      transaction: '=transaction'
    },
    templateUrl: 'templates/amount.jade',
    link: link
  };
  return directive;

  function link(scope, elem, attrs) {
    scope.settings = Wallet.settings;
    scope.isBitCurrency = currency.isBitCurrency;
    scope.toggle = Wallet.toggleDisplayCurrency;
    scope.absolute = (value) => Math.abs(value);
  }
}

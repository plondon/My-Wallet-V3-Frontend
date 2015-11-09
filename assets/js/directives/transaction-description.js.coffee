angular.module('walletApp').directive('transactionDescription', ($translate, $rootScope, Wallet, $compile, $sce) ->
  {
    restrict: "E"
    replace: 'false'
    scope: {
      tx: '=transaction'
      search: '=highlight'
    }
    templateUrl: 'templates/transaction-description.jade'
    link: (scope, elem, attrs) ->

      scope.action = ((type) ->
        switch type
          when 'sent'
            return 'SENT'
          when 'received'
            return 'RECEIVED_BITCOIN_FROM'
          when 'transfer'
            return 'MOVED_BITCOIN_TO'
      )(scope.tx.txType)

      formatLabel = (coins, keepChange) ->
        used = {}
        coins
          .filter((coin) -> !coin.change || keepChange)
          .map((coin) -> coin.label || coin.address)
          .filter((label) ->
            didUse = used[label] == true
            used[label] = true
            return !didUse
          ).join(', ')

      if scope.tx.txType == 'sent'
        scope.primaryLabel = formatLabel(scope.tx.processedOutputs)
        scope.secondaryLabel = formatLabel(scope.tx.processedInputs, true)
      else
        scope.primaryLabel = formatLabel(scope.tx.processedInputs, true)
        scope.secondaryLabel = formatLabel(scope.tx.processedOutputs)

      scope.$watch 'search', (search) ->
        return unless search?
        s = search.toLowerCase()
        searchInAddress = scope.primaryLabel.toLowerCase().search(s) > -1
        searchInOther = scope.secondaryLabel.toLowerCase().search(s) > -1
        scope.tx.toggled = !searchInAddress && searchInOther

  }
)

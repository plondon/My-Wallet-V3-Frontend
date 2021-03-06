'use strict';

angular
  .module('walletFilters', [])
  .filter('toBitCurrency', toBitCurrencyFilter)
  .filter('convert', convertFilter)
  .filter('getByProperty', getByPropertyFilter)
  .filter('getByPropertyNested', getByPropertyNestedFilter)
  .filter('addressOrNameMatch', addressOrNameMatchFilter);

toBitCurrencyFilter.$inject = ['currency'];
function toBitCurrencyFilter(currency) {
  return function (input, btcCurrency, hideCurrency) {
    if (input != null && !isNaN(input) && btcCurrency != null) {
      let amount = currency.convertFromSatoshi(input, btcCurrency);
      return currency.formatCurrencyForView(amount, btcCurrency, !hideCurrency);
    } else {
      return '';
    }
  };
}

convertFilter.$inject = ['Wallet', 'currency'];
function convertFilter(Wallet, currency) {
  return function (amount) {
    let curr = Wallet.settings.displayCurrency || currency.bitCurrencies[0];
    let conversion = currency.convertFromSatoshi(amount, curr);
    return currency.formatCurrencyForView(conversion, curr);
  };
}

function getByPropertyFilter() {
  return function (propertyName, propertyValue, collection) {
    let i = 0;
    let len = collection.length;
    while (i < len) {
      if (collection[i][propertyName] === propertyValue) {
        return collection[i];
      }
      i++;
    }
    return null;
  };
}

function getByPropertyNestedFilter() {
  return function(propertyName, propertyValue, collection) {
    let i = 0;
    let len = collection.length;
    while (i < len) {
      let subCollection = collection[i][propertyName];
      let j = 0;
      let len2 = subCollection.length;
      while (j < len2) {
        if (collection[i][propertyName][j] === propertyValue) {
          return collection[i];
        }
        j++;
      }
      i++;
    }
    return null;
  };
}

function addressOrNameMatchFilter() {
  return function (addresses, q) {
    if (q == null || q === '') return addresses;
    q = q.toLowerCase();
    return addresses.filter(function (addr) {
      let keep;
      keep = addr.account != null && addr.account.label.toLowerCase().indexOf(q) > -1;
      keep = keep || (addr.label != null) && addr.label.toLowerCase().indexOf(q) > -1;
      keep = keep || addr.address.toLowerCase().indexOf(q) > -1;
      return keep;
    });
  };
}

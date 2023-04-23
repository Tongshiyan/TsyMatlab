
function accuracy = calAccuracy(dataTest,RF_prection)
      [m,n] = size(dataTest);
      A = dataTest(:,n);
      right = sum(A == RF_prection);
      accuracy = right/m;
end
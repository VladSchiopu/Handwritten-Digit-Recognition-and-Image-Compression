function new_X = task2(photo, pcs)
  [m, n] = size(photo);
  
  % Initializare matrice finala.
  new_X = zeros(m, n);
  
  % Cast photo la tipul double.
  photo = double(photo);
  
  % Normalizează matricea initială scăzând din ea media fiecărui rând.
  photo_mean = zeros(m,n);
  for i = 1:m,
    photo_mean(i,:) = mean(photo(i,:),2);
    photo(i,:) = photo(i,:) - photo_mean(i,:);
  endfor
  
  % Construiește matricea Z.
  Z = photo';
  
  % Calculează matricile U, S și V din descompunerea SVD a matricei Z.
  [U, S, V] = svd(Z);
  
  % Construiește matricea W din primele pcs coloane ale lui V.
  W = V(:, 1:pcs);
  
  % Calculează matricea Y.
  Y = W' * photo;
  
  % Aproximează matricea inițială.
  new_X = W * Y + photo_mean;
  
  % Transformă matricea în uint8 pentru a fi o imagine validă.
  new_X = uint8(new_X);
endfunction
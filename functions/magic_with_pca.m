## Copyright (C) 2021 Andrei
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} magic_with_pca (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-08

function [train, miu, Y, Vk] = magic_with_pca(train_mat, pcs)
  [m, n] = size(train_mat);

  % initializare train
  train = zeros(m, n);

  % initializare miu
  miu = zeros(1, n);

  % initializare Y
  Y = zeros(m, pcs);

  % initializare Vk
  Vk = zeros(n, pcs);

  % TODO: cast train_mat la double
  train_mat = double(train_mat);

  % TODO: calculează media fiecărui rând al matricii
  miu = mean(train_mat, 1);

  % TODO: scade media din matricea inițială
  train_mat = train_mat - miu;

  % TODO: calculează matricea de covarianță
  Z = (train_mat' * train_mat) / (m - 1);

  % TODO: calculează vectorii și valorile proprii ale matricei de covarianță
  % HINT: functia eig
  [V, S] = eig(Z);

  % TODO: ordoneaza descrescator valorile proprii si creaza o matrice V
  % formata din vectorii proprii asezati pe coloane, astfel incat prima coloana
  % sa fie vectorul propriu corespunzator celei mai mari valori proprii si
  % asa mai departe.
  [S, indices] = sort(diag(S), 'descend');
  V = V(:, indices);

  % TODO: păstrează doar primele pcs coloane din matricea V
  Vk = V(:, 1:pcs);

  % TODO: creează matricea Y schimbând baza matricii initiale
  Y = train_mat * Vk;

  % TODO: calculează matricea train care este o aproximare a matricii inițiale
  train = Y * Vk' + miu;
endfunction
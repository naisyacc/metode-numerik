
function c = Biseksi(f,a,b,n,tol)
  % Menghitung nilai fungsi pada titik a dan b
  fa = f(a);
  fb = f(b);

  % Memastikan terdapat perubahan tanda pada interval
  if fa*fb > 0
    error('Interval tidak mengurung akar karena fa dan fb bertanda sama.');
  endif

  fprintf('\nIter\ta\t\tb\t\tfa\t\tfb\t\tc\t\tfc\n');

  % Iterasi metode biseksi
  for i = 1:n
    % Menghitung titik tengah
    c = (a+b)/2;
    fc = f(c);

    % Menampilkan hasil iterasi
    fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\n', ...
            i,a,b,fa,fb,c,fc);

    % Berhenti jika akar ditemukan atau toleransi tercapai
    if abs(fc) <= tol || abs(b-a)/2 <= tol
      break;
    endif

    % Memperbarui interval berdasarkan perubahan tanda
    if fa*fc < 0
      b = c;
      fb = fc;
    elseif fa*fc > 0
      a = c;
      fa = fc;
    else
      % Jika fc = 0, akar ditemukan tepat
      break;
    endif
  endfor
end


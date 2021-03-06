LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY seg72 IS
  PORT(
  entrada: in std_logic_vector(5 downto 0);
  s2: out std_logic_vector(6 downto 0)
  );
end seg72;

architecture hardware of seg72 is
begin 
  with entrada select
  s2 <= "1000000" when "000000",--00
		  "1000000" when "000001",--01
		  "1000000" when "000010",--02
		  "1000000" when "000011",--03
		  "1000000" when "000100",--04
		  "1000000" when "000101",--05
		  "1000000" when "000110",--06
		  "1000000" when "000111",--07
		  "1000000" when "001000",--08
		  "1000000" when "001001",--09
		  "1111001" when "001010",--10
		  "1111001" when "001011",--11
		  "1111001" when "001100",--12
		  "1111001" when "001101",--13
		  "1111001" when "001110",--14
		  "1111001" when "001111",--15
		  "1111001" when "010000",--16
		  "1111001" when "010001",--17
		  "1111001" when "010010",--18
		  "1111001" when "010011",--19
		  "0100100" when "010100",--20
		  "0100100" when "010101",--21
		  "0100100" when "010110",--22
		  "0100100" when "010111",--23
		  "0100100" when "011000",--24
		  "0100100" when "011001",--25
		  "0100100" when "011010",--26
		  "0100100" when "011011",--27
		  "0100100" when "011100",--28
		  "0100100" when "011101",--29
		  "0110000" when "011110",--30
		  "0110000" when "011111",--31
		  "0110000" when "100000",--32
		  "0110000" when "100001",--33
		  "0110000" when "100010",--34
		  "0110000" when "100011",--35
		  "0110000" when "100100",--36
		  "0110000" when "100101",--37
		  "0110000" when "100110",--38
		  "0110000" when "100111",--39
		  "0011001" when "101000",--40
		  "0011001" when "101001",--41
		  "0011001" when "101010",--42
		  "0011001" when "101011",--43
		  "0011001" when "101100",--44
		  "0011001" when "101101",--45
		  "0011001" when "101110",--46
		  "0011001" when "101111",--47
		  "0011001" when "110000",--48
		  "0011001" when "110001",--49
	     "0010010" when "110010",--50
		  "0010010" when "110011",--51
	     "0010010" when "110100",--52
	     "0010010" when "110101",--53 
 		  "0010010" when "110110",--54
		  "0010010" when "110111",--55
		  "0010010" when "111000",--56	 
		  "0010010" when "111001",--57
		   "0000000" when "111010",--58
		  "0010010" when "111011",--59
        "0111111" when others;
end hardware;
--TDMS encoder
--Benoît Chappet de Vangel
--25/11/15




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.ieee.numeric_std.ALL;


--------------------------------------------------------------
--function bitsum
--Params:
--data std_logic_vector
--return  the sum of bits inside data unsigned(3 downto 0)
--precond len(data)  < 15
--------------------------------------------------------------
function bitsum(data : in std_logic_vector) return unsigned is
    sum : unsigned(3 downto 0);
begin
    sum := (others => '0');
    for i in range data'left to data'right loop
        sum := sum + data(i)
    end loop;
    return sum;
end bitsum;


--------------------------------------------------------------
--module TDMS_ENCODER
--encode incoming 8bit data into 10bit tdms to reduce  DC bias and transitions

--INPUT:
--data  8b
--blank 1b
--c     2b control to send during blanck periods

--OUTPUT:TMS encoded data
--------------------------------------------------------------
architecture Behavioural of TDMS_ENCODER is
    Port(
        signal data : in std_logic_vector(7 downto 0);
        signal c : in std_logic_vector(1 downto 0);
        signal blank : in std_logic;
        
        signal encoded : out std_logic(9 downto 0);
    );


    signal data_xor,data_xnor : std_logic_vector(8 downto 0);
    signal control : std_logic_vector(1 downto 0); -- "c0,c1"
    signal ones : unsigned(3 downto 0) := (others => '0'); --nb of ones in data
    signal data_word : std_logic_vector(8 downto 0); --data_word data after transformation

    signal one_word : unsigned(3 downto 0) := (others => '0'); --sum of one in data_word
    signal inversion_condition : std_logic; --true when we inverse

    signal encoded_i : std_logic_vector(9 downto 0); --inside value of encoded

    signal mean_one : unsigned(3 downto 0) := (others => '0'); --average number of 1 over time

begin

    
    --else we encode the data with the two available scheme

    --encoding with xor 
    data_xor(0) <= data(0);
    for i in 1 to 7 generate
        data_xor(i) <= data(i) xor data_xor(i-1);
    end generate;
    data_xor(8) <= '1'; --ninth bit show the encoding scheme 

    --encoding with xnor 
    data_xnor(0) <= data(0);
    for i in 1 to 7 generate
        data_xnor(i) <= data(i) xnor data_xnor(i-1);
    end generate;
    data_xnor(8) <= '0'; --ninth bit show the encoding scheme 


    
    --to choose the encoding scheme which give fewest transitions
    ones <= bitsum(data);
    data_word <= data_xnor if ones > 4 or (ones = 4 and data(0) = '0') else data_xor;

    --now inverse the word if it reduces the DC bias
    one_word <= bitsum(data_word);

    --we inverse the word if the nb of one will not help the mean_one to balance
    inversion_condition <=  (mean_one > 5 and one_word > 5) or
                                (mean_one < 5 and one_word < 5);

    encoded_word(8 downto 0) <= not(data_word) if inversion_condition else data_word;
    encoded_word(9) <= '1' if inversion_condition else '0';


    --Update the mean and the output at each clk event
    process(clk,rst)
    begin
        if rst = '1' then
            mean_one = (others <= '0');
        elsif rising_edge(clk) then
            if blank = '1' then
                --if control is on we have a special output
                case c is
                    when "00" => encoded_i <= "0010101011";
                    when "01" => encoded_i <= "0010101010";
                    when "10" => encoded_i <= "1101010100";
                    when "11" => encoded_i <= "1101010101";
                end case;
                mean_one <= mean_one; --mean does not change
            else
                encoded_i <= encoded_word;
                sum_encoded = sum_encoded(encoded_word);
                mean_one <= (mean_one + sum_encoded) << 1 -- mean = (mean+sum)/2
           end if;
        end if;
    end process;
    encoded <= encoded_i;
end Behavioural;


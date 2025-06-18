//SPDX-License-Identifier:None
pragma solidity>0.8.0;

contract ERC20AC{
    event Transfer (address indexed from,  address indexed to,      uint value);
    event Approval (address indexed owner, address indexed spender, uint value);

    mapping(address => mapping(address => uint)) public allowance;
    mapping(address => uint)                     public balanceOf;
    uint                                         public totalSupply;
    uint constant                                public decimals    = 18;
    string constant                              public name        = "USD Tether";
    string constant                              public symbol      = "USDT";

    function approve (address a, uint b) external returns (bool) {
        
        emit Approval(msg.sender, a, allowance[msg.sender][a] = b);
        return true;

    }

    function transfer (address a, uint b) external returns (bool) {

        return transferFrom(msg.sender, a, b);

    }
    
    function transferFrom (address a, address b, uint c) public returns (bool) {

        unchecked {

            uint allow = allowance[a][b];    

            assert(balanceOf[a] >= c);
            assert(a == msg.sender || allow >= c);


            if (allow >= c) allowance[a][b] -= c;
            (balanceOf[a] -= c, balanceOf[b] += c);

            emit Transfer(a, b, c);
            return true;

        }

    }

    function mint () external {

        uint amt = 100 * 10 ** decimals;
        balanceOf[msg.sender] += amt;

        emit Transfer(address(0), msg.sender, amt);

    }

}

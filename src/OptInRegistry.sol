// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IERC721 {
    function ownerOf(uint256 tokenId) external view returns (address owner);
}

contract OptInRegistry is Ownable {

    event OptionAdded(address indexed tokenOwner, string endpoint);

    address public tokenContract;
    string public defaultString;
    uint256 optionCount;
    mapping(uint256 => string) public optionStrings;
    mapping(uint256 => uint256) public activeOptions;
    mapping(uint256 => uint256) public optionsToTokenIds; // keep track
    mapping(uint256 => uint256) public endorsements;
    mapping(address => uint256) public addressToEndorsement;

    constructor (address _tokenContract, string memory _defaultEndpoint) {
        tokenContract = _tokenContract;
        defaultEndpoint = _defaultEndpoint;
    }

    /*//////////////////////////////////////////////////////////////
                                Owner
    //////////////////////////////////////////////////////////////*/

    function setDefaultString(string memory _defaultEndpoint) public onlyOwner {
        defaultEndpoint = _defaultEndpoint;
    }

    // function setTokenContract(address _tokenContract) public onlyOwner {
    //     tokenContract = _tokenContract;
    // }

    /*//////////////////////////////////////////////////////////////
                                Public
    //////////////////////////////////////////////////////////////*/

    function addOption(string memory _string, uint256 _tokenId) public {
        require(IERC721(tokenContract).ownerOf(_tokenId) == msg.sender, "NOT_OWNER");
        require(bytes(_string).length > 0, "INVALID_STRING");
        optionCount++;
        optionStrings[optionCount] = _string;
        optionsToTokenIds[optionCount] = _tokenId;
        emit OptionAdded(msg.sender, _string);
    }

    function deleteOption(uint256 _optionIndex, uint256 _tokenId) public {
        require(IERC721(tokenContract).ownerOf(_tokenId) == msg.sender, "NOT_OWNER");
        require(_optionIndex <= optionCount, "INVALID_OPTION_INDEX");
        require(bytes(optionStrings[_optionIndex]).length > 0, "INVALID_OPTION_INDEX");
        require(optionsToTokenIds[_optionIndex] == _tokenId, "INVALID_TOKEN_ID");
        delete optionStrings[_optionIndex];
    }

    function endorse(uint256 _optionIndex, uint256 _tokenId) public {
        require(IERC721(tokenContract).ownerOf(_tokenId) == msg.sender, "NOT_OWNER");
        require(_optionIndex <= optionCount, "INVALID_OPTION_INDEX");
        if (addressToEndorsement[msg.sender] > 0) {
            endorsements[addressToEndorsement[msg.sender]]--;
        }
        endorsements[_optionIndex]++;
        addressToEndorsement[msg.sender] = _optionIndex;
    }

    function optIn(uint256 _optionIndex, uint256 _tokenId) public {
        require(IERC721(tokenContract).ownerOf(_tokenId) == msg.sender, "NOT_OWNER");
        require(_optionIndex <= optionCount, "INVALID_OPTION_INDEX");
        require(bytes(optionStrings[_optionIndex]).length > 0, "INVALID_OPTION_INDEX");
        activeOptions[_tokenId] = _optionIndex;
    }

    function optOut(uint256 _tokenId) public {
        require(IERC721(tokenContract).ownerOf(_tokenId) == msg.sender, "NOT_OWNER");
        activeOptions[_tokenId] = 0;
    }

    /*//////////////////////////////////////////////////////////////
                                 View
    //////////////////////////////////////////////////////////////*/

    function getActiveOption(uint256 _tokenId) public view returns (string memory) {
        if (activeOptions[_tokenId] > 0 && bytes(optionStrings[activeOptions[_tokenId]]).length > 0) {
            return optionStrings[activeOptions[_tokenId]];
        } else {
            return defaultString;
        }
    }

    function getActiveOptionId(uint256 _tokenId) public view returns (uint256) {
        if (activeOptions[_tokenId] > 0 && bytes(optionStrings[activeOptions[_tokenId]]).length > 0) {
            return activeOptions[_tokenId];
        } else {
            return 0;
        }
    }

    function getOption(uint256 _optionIndex) public view returns (string memory) {
        require(_optionIndex <= optionCount, "INVALID_OPTION_INDEX");
        return optionStrings[_optionIndex];
    }
}

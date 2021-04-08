package ga.bowwow.service.pet.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ga.bowwow.service.pet.Pet;
import ga.bowwow.service.pet.PetService;
import ga.bowwow.service.user.VO.UserAccount;
import ga.bowwow.service.user.VO.UserDTO;

@Service("petService")
public class PetServiceImpl implements PetService {
	
	@Autowired
	private PetDAO petDAO;
	
	public PetServiceImpl() {
		System.out.println(">> PetServiceImpl() 객체생성!!!");
	}
	
	@Override
	public int insertPetInfo(Pet pet) {
		return petDAO.insertPetInfo(pet);
	}

	@Override
	public int updatePetInfo(Pet pet) {
		return petDAO.updatePetInfo(pet);
	}

	@Override
	public int deletePetInfo(Pet pet) {
		return petDAO.deletePetInfo(pet);
	}

	@Override
	public List<Pet> getPetInfoList(Pet pet) {
		return petDAO.getPetInfoList(pet);
	}

	@Override
	public Pet getPetInfo(Pet pet) {
		return petDAO.getPetInfo(pet);
	}

	@Override
	public List<Pet> getMyHomePetList(int member_serial) {
		return petDAO.getMyHomePetList(member_serial);
	}

}

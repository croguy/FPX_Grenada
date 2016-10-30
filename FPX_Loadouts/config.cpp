class CfgPatches
{
  class FPX_Factions_B {
    name = "FPX Factions - BLUFOR";
    units[] = {
      #include "FPX_Factions_B_CAF\CfgPatches_Units.hpp"
    };
    weapons[] = {};
    requiredAddons[] = {
      "A3_Characters_F",
      "A3_Weapons_F",
      "FPX_Factions_B_DTA"
    };
    authors[] = {"Versten", "Croguy"};
  };
};
class CfgFactionClasses
{
  class FPX_B_CAF {
    displayName = "CAF";
  };
};
class CfgEditorSubcategories {
  #include "FPX_Factions_B_CAF\CfgEditorSubcategories.hpp"
};
class CfgVehicles
{
  class B_Soldier_F;
	class B_Soldier_02_F;
	class B_Soldier_03_F;

  #include "FPX_Factions_B_CAF\CfgVehicles.hpp"
};
class CfgWeapons
{
  class Default;
	class ItemCore: Default{};
  class VestItem;
  class UniformItem: ItemCore {
		class ItemInfo;
	};
  class Uniform_Base: ItemCore {
		class ItemInfo;
	};
  class Vest_NoCamo_Base;
  class V_PlateCarrier1_rgr : Vest_NoCamo_Base {
    class ItemInfo;
  };
  class V_PlateCarrier2_rgr : Vest_NoCamo_Base {
    class ItemInfo;
  };
  class H_HelmetIA;
  class rhs_weap_m16a4_carryhandle;
  class rhs_weap_m4a1_carryhandle;
  class CUP_lmg_m249_pip1;

  #include "FPX_Factions_B_CAF\CfgWeapons.hpp"
};

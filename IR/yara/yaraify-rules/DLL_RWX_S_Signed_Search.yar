import "pe"

rule DLL_RWX_S_Signed_Search
{
    meta:
        description = "Detects RWX-S signed DLLs. This verifies that the image contains a signature, not that it is valid."
        author = "Vshex"
        date = "2024-09-19"  
        yarahub_uuid = "aec5dad9-7636-4c9b-9d89-20f3e26b0f23" 
        yarahub_license = "CC0 1.0" 
        yarahub_rule_matching_tlp = "TLP:WHITE" 
        yarahub_rule_sharing_tlp = "TLP:WHITE"
        yarahub_reference_md5 = "3b25a34bb08f4759792c24b121109506"  

	condition:
	pe.is_dll() and
		for any i in (0..pe.number_of_sections - 1): (
			(pe.sections[i].characteristics & pe.SECTION_MEM_READ) and
			(pe.sections[i].characteristics & pe.SECTION_MEM_EXECUTE) and
			(pe.sections[i].characteristics & pe.SECTION_MEM_WRITE) and
			(pe.sections[i].characteristics & pe.SECTION_MEM_SHARED) )
		and pe.number_of_signatures > 0
}
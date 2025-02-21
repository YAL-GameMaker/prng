{
    "id": "897059ab-6c2a-4b63-a648-db09480cff45",
    "modelName": "GMExtension",
    "mvc": "1.2",
    "name": "PRNG",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": true,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 113497714299118,
    "date": "2019-34-12 01:12:29",
    "description": "",
    "exportToGame": true,
    "extensionName": "",
    "files": [
        {
            "id": "bac80d6c-a2e2-445c-9d9d-6141adb131a5",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "PRNG.dll",
            "final": "",
            "functions": [
                {
                    "id": "87978acc-c4ca-1f85-4268-f84c74cabb6a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "prng_init_protos",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "prng_init_protos",
                    "returnType": 2
                },
                {
                    "id": "b4a4b9ff-2a24-f1b6-ac86-cb7f4d8e22f9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "well512_create_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_create_raw",
                    "returnType": 2
                },
                {
                    "id": "69796422-f7f9-2c6b-bd97-da6e541777a4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "well512_destroy_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_destroy_raw",
                    "returnType": 2
                },
                {
                    "id": "6e254624-aa47-1654-1698-bed46e518268",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "well512_set_seed_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_set_seed_raw",
                    "returnType": 2
                },
                {
                    "id": "87978acc-2a24-f185-e8c2-bc083717cc1a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "well512_uint32_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_uint32_raw",
                    "returnType": 2
                },
                {
                    "id": "b6adce8e-ff12-6123-6498-412ee3fb28e0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "well512_bits_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_bits_raw",
                    "returnType": 2
                },
                {
                    "id": "d2c2df99-3b35-e0d0-e8c2-f84c7206885f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "well512_float_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_float_raw",
                    "returnType": 2
                },
                {
                    "id": "a4a516c7-4dc1-c4b2-4376-687c4f3b6b8f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        2,
                        2
                    ],
                    "externalName": "well512_float_range_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_float_range_raw",
                    "returnType": 2
                },
                {
                    "id": "1e0e1355-a2ac-791c-351f-70c4ff8e11c3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "well512_int_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_int_raw",
                    "returnType": 2
                },
                {
                    "id": "3d167524-1865-074c-9f01-956ef1581bf1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        2,
                        2
                    ],
                    "externalName": "well512_int_range_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "well512_int_range_raw",
                    "returnType": 2
                },
                {
                    "id": "87978acc-1917-c285-240e-43f7c72433ea",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "yyri_well512_create_raw_yyr",
                    "help": "yyri_well512_create_raw()",
                    "hidden": false,
                    "kind": 1,
                    "name": "yyri_well512_create_raw",
                    "returnType": 2
                },
                {
                    "id": "8e254635-8e03-4307-2f67-74747164d75b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "yyri_well512_set_seed_yyr",
                    "help": "yyri_well512_set_seed(rng, seed)",
                    "hidden": false,
                    "kind": 1,
                    "name": "yyri_well512_set_seed",
                    "returnType": 2
                },
                {
                    "id": "68c34392-1752-3b42-7153-3d10495f1653",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "yyri_well512_float_yyr",
                    "help": "yyri_well512_float(rng, _max)",
                    "hidden": false,
                    "kind": 1,
                    "name": "yyri_well512_float",
                    "returnType": 2
                },
                {
                    "id": "de254660-93de-cb83-66ba-e12ca986f53d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "prng_init_1",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "prng_init_1",
                    "returnType": 2
                },
                {
                    "id": "56adce60-b2cf-5219-c901-7b83de94d75b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "prng_init_array",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "prng_init_array",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\PRNG.dll",
            "uncompress": false
        },
        {
            "id": "7cc73678-e3b5-432b-8372-a1d5779ceb4b",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "PRNG.gml",
            "final": "",
            "functions": [
                {
                    "id": "2c3ce938-b070-5d29-9aec-c2baab792568",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "prng_init",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "prng_init",
                    "returnType": 2
                },
                {
                    "id": "f15ada0b-846f-91e2-7ae7-795a92ef18b4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "prng_prepare_buffer",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "prng_prepare_buffer",
                    "returnType": 2
                },
                {
                    "id": "73b4396a-0069-a785-b654-7f5926b5649a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "uwell512_create",
                    "help": "uwell512_create()->",
                    "hidden": false,
                    "kind": 2,
                    "name": "uwell512_create",
                    "returnType": 2
                },
                {
                    "id": "7ac61c31-573a-0dc4-4935-3e49b65b8fb6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "yyri_well512_create",
                    "help": "yyri_well512_create()",
                    "hidden": false,
                    "kind": 2,
                    "name": "yyri_well512_create",
                    "returnType": 2
                }
            ],
            "init": "prng_init",
            "kind": 2,
            "order": [
                
            ],
            "origname": "extensions\\gml.gml",
            "uncompress": false
        },
        {
            "id": "962d9a80-fb98-4072-93ea-c79e5ae6f0f4",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": -1,
            "filename": "autogen.gml",
            "final": "",
            "functions": [
                {
                    "id": "82a192aa-9232-05a6-3c6b-1af2bd583f97",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "well512_create",
                    "help": "well512_create()->",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_create",
                    "returnType": 2
                },
                {
                    "id": "0c73b0f7-3acc-4953-6b3e-cf577b86abda",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "well512_destroy",
                    "help": "well512_destroy(rng)",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_destroy",
                    "returnType": 2
                },
                {
                    "id": "4e0926b3-002e-2bd2-3e87-dbb244321d21",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "well512_set_seed",
                    "help": "well512_set_seed(rng, new_seed:int)",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_set_seed",
                    "returnType": 2
                },
                {
                    "id": "bb991a58-fc3b-b631-6b15-4393bbb59864",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "well512_uint32",
                    "help": "well512_uint32(rng)->int",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_uint32",
                    "returnType": 2
                },
                {
                    "id": "96e91f55-9232-24b7-280e-b07f44b6d1a7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "well512_bits",
                    "help": "well512_bits(rng, count:int)->int",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_bits",
                    "returnType": 2
                },
                {
                    "id": "a4f007d6-5d80-80f7-59d5-5b0e3951803c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "well512_float",
                    "help": "well512_float(rng, max:number)->number",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_float",
                    "returnType": 2
                },
                {
                    "id": "c609f84c-faac-f62e-df99-33e188d860ea",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "well512_float_range",
                    "help": "well512_float_range(rng, min:number, max:number)->number",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_float_range",
                    "returnType": 2
                },
                {
                    "id": "798725f4-7aac-5d2f-8738-868846af3562",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "well512_int",
                    "help": "well512_int(rng, max:int)->int",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_int",
                    "returnType": 2
                },
                {
                    "id": "6ff475a3-5e92-3e90-b62b-1d77e768fb42",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "well512_int_range",
                    "help": "well512_int_range(rng, min:int, max:int)->int",
                    "hidden": false,
                    "kind": 2,
                    "name": "well512_int_range",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 2,
            "order": [
                
            ],
            "origname": "extensions\\autogen.gml",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": true,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "Proprietary",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "options": null,
    "optionsFile": "options.json",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "supportedTargets": 113497714299118,
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "1.0.0"
}
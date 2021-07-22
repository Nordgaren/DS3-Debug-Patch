#include "ds3debugmenuex.h"

#include <thread>
#include <vector>
#include <string>
#include <mutex>

using namespace std;

//141A645E0 -- gets demolished
//145CFBB5D
//145721DD5
//1458C4546 -- CHECK (not important?)
//1454DAA14 -- CHECK (not important?)
//third one even lol (CRASH)

//145E42FA8 - interesting
#define NUM_PATCH_THREADS 10

//vector<vector<PatchJob>> patchJobs;
vector<PatchJob> patchJobs;
bool threadStartupMarkers[NUM_PATCH_THREADS] = { false };
bool threadFinishMarkers[NUM_PATCH_THREADS] = { false };
int threadShitMarkers[NUM_PATCH_THREADS] = { 0 };
int threadIndices[NUM_PATCH_THREADS];
//mutex pjMutex;
HANDLE pjMutex;
HANDLE patchingThreads[NUM_PATCH_THREADS];

DWORD64 bClearRenderTargetViewGrey = 0;
DWORD64 bLoadDbgFont = 0;
DWORD64 bInitDebugBootMenuStep = 0;
DWORD64 bInitMoveMapListStep = 0;
DWORD64 bGameStepSelection = 0;
DWORD64 bCheckDebugDashSwitch = 0;
DWORD64 bLoadGameProperties = 0;
DWORD64 bDecWindowCounter = 0;
DWORD64 bIncWindowCounter = 0;
DWORD64 bMoveMapSaveFix = 0;
DWORD64 bCheckSaveDisabled = 0;
DWORD64 bDisableSave = 0;
DWORD64 bEnableSave = 0;

BYTE pGestureBytes[1] = { 0x75 };

BYTE pFreeCamBytes1[5] = { 0xE8, 0xBD, 0xB0, 0xD0, 01 };
BYTE pFreeCamBytes2[35] = { 0x44, 0x88, 0xA6, 0x98, 0x00, 0x00, 0x00, 0x8B, 0x83, 0xE0, 0x00, 0x00, 0x00, 0xFF, 0xC8, 0x83, 0xF8, 0x01, 0x0F, 0x87, 0x35, 0x01, 0x00, 0x00, 0x44, 0x88, 0xBE, 0x98, 0x00, 0x00, 0x00 };
BYTE dbgFontPatch[2] = { 0xEB, 0x10 };
BYTE moveMapListStepPatch[18] = { 0xC7, 0x46, 0x10, 0xFF, 0xFF, 0xFF, 0xFF, 0x48, 0x8B, 0x74, 0x24, 0x38, 0x48, 0x83, 0xC4, 0x20, 0x5F, 0xC3};
BYTE sfxGUIPatch1[16] = { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90 };
BYTE sfxGUIPatch2[8] = { 0x48, 0x8B, 0x8A, 0x40, 0x03, 0x00, 0x00, 0x90 };
BYTE checkProfileIdxPatch[5] = { 0x90, 0x90, 0x83, 0xF8, 0x09 };

DWORD64* EzTextlistSelectorVtable = new DWORD64[23];
DWORD64* MoveMapListStepVtable = new DWORD64[5];
DWORD64* debugBootMenuStepVtable = new DWORD64[16];

DWORD64 whatever;

DWORD64 fDeleteDC = (DWORD64)DeleteDC;
DWORD64 fCreateCompatibleDC = (DWORD64)CreateCompatibleDC;
uint64_t DbgDispLoadingAddress = (uint64_t)&fDbgDispLoading;
uint64_t pinitDebugBootMenuStepFunctions = (uint64_t)&initDebugBootMenuStepFunctions;

tDirectInput8Create oDirectInput8Create;

inline void Hook(LPVOID address, int numBytes, LPVOID pFunction, DWORD64* returnPoint)
{
    *returnPoint = (DWORD64)address + numBytes;
    MH_CreateHook(address, pFunction, 0);
    MH_EnableHook(address);
}

inline void MemcpyProtected(uint64_t address, int length, void* bytes)
{
    DWORD oldProtect;

    VirtualProtect((LPVOID)address, length, PAGE_EXECUTE_READWRITE, &oldProtect);
    memcpy((void*)address, bytes, length);
    VirtualProtect((LPVOID)address, length, oldProtect, &oldProtect);
}

inline void WriteProtected(uint64_t address, BYTE value)
{
    DWORD oldProtect;

    VirtualProtect((LPVOID)address, 1, PAGE_EXECUTE_READWRITE, &oldProtect);
    *(BYTE*)address = value;
    VirtualProtect((LPVOID)address, 1, oldProtect, &oldProtect);
}

inline void WriteProtected(uint64_t address, short value)
{
    DWORD oldProtect;

    VirtualProtect((LPVOID)address, 2, PAGE_EXECUTE_READWRITE, &oldProtect);
    *(short*)address = value;
    VirtualProtect((LPVOID)address, 2, oldProtect, &oldProtect);
}

inline void WriteProtected(uint64_t address, int value)
{
    DWORD oldProtect;

    VirtualProtect((LPVOID)address, 4, PAGE_EXECUTE_READWRITE, &oldProtect);
    *(int*)address = value;
    VirtualProtect((LPVOID)address, 4, oldProtect, &oldProtect);
}

inline void WriteProtected(uint64_t address, long long value)
{
    DWORD oldProtect;

    VirtualProtect((LPVOID)address, 8, PAGE_EXECUTE_READWRITE, &oldProtect);
    *(long long*)address = value;
    VirtualProtect((LPVOID)address, 8, oldProtect, &oldProtect);
}

void SetUpVtables()
{
    for (int i = 0; i < 21; i++)
    {
        EzTextlistSelectorVtable[i] = *(DWORD64*)(0x142894A08 + i * 8);
    }

    //Add functions
    EzTextlistSelectorVtable[21] = EzTextlistSelectorVtable[9];
    EzTextlistSelectorVtable[22] = (DWORD64)&sub_140CF3520;

    //Make additional modifications
    EzTextlistSelectorVtable[1] = (DWORD64)&EzTextlistSelectorDtor;
    EzTextlistSelectorVtable[2] = 0x14065AD60;

    for (int i = 0; i < 5; i++)
    {
        MoveMapListStepVtable[i] = *(DWORD64*)(0x142849EC8 + i * 8);
    }
    
    //Make additional modifications
    MoveMapListStepVtable[1] = (DWORD64)&MoveMapListStepDtor;

    for (int i = 0; i < 16; i++)
    {
        debugBootMenuStepVtable[i] = *(DWORD64*)(0x14285F128 + i * 8);
    }

    //Make additional modifications
    debugBootMenuStepVtable[1] = (DWORD64)&debugBootMenuStepDtor;
}

//"A delayed patch is eventually good, but a rushed patch is forever bad."
//-Miyamoto
void ExtraDelayedPatches()
{
    DWORD dBypassCheck1 = 0;
    DWORD dBypassCheck2 = 0;

    Sleep(2000); //Kill me

    //Pav patches
    MemcpyProtected(0x14080A2F0, 2, mov1ToAlBytes); //-- Enable INS
    MemcpyProtected(0x14080A2E0, 2, mov1ToAlBytes); //-- Enable Event
    MemcpyProtected(0x140E82DEE, 5, xorRaxBytes); //-- (HeatMap Menu) Crash on load so it's disabled

    MemcpyProtected(0x14062C3AE, 5, pFreeCamBytes1);
    MemcpyProtected(0x14062C401, 31, pFreeCamBytes2);

    //Enable ChrDbgDraw
    MemcpyProtected(0x1408D8049, 5, mov1ToAlBytes);

    dBypassCheck1 = 0x0030EEA3;
    //MemcpyProtected(0x1408B1CF1, 4, &dBypassCheck1); //Bypass the check that bricks saves
    WriteProtected(0x1408B1CF1, (int)dBypassCheck1);
    dBypassCheck2 = 0xFFE48E31;
    WriteProtected(0x140EE7C01, (int)dBypassCheck2);

    //Enable system.properties (maybe???)
    int systemPropertiesValue = 3;
    WriteProtected(0x140EC365F, systemPropertiesValue);

    //Enable game.properties
    Hook((LPVOID)0x14080905B, 7, &tLoadGameProperties, &bLoadGameProperties);

    Hook((LPVOID)0x1422ED2FC, 6, &decWindowCounter, &bDecWindowCounter);
    //Hook((LPVOID)0x14045399C, 6, &incWindowCounter, &bIncWindowCounter);
    Hook((LPVOID)0x1422F0522, 7, &incWindowCounter, &bIncWindowCounter);

    //Pav patch for sfx GUI menus
    MemcpyProtected(0x140250A5F, 16, sfxGUIPatch1);
    //MemcpyProtected(0x140DF3F56, 8, sfxGUIPatch2);

    SetUnhandledExceptionFilter(UHFilter);
}

void DelayedPatches()
{
    //Boot Menu
    //int size = 0x230;
    //WriteProtected(0x140ED13F1, size);
    //Hook((LPVOID)0x140ED1457, 5, &tInitDebugBootMenuStep, &bInitDebugBootMenuStep);
    Hook((LPVOID)0x140ED1440, 5, &tInitDebugBootMenuStep, &bInitDebugBootMenuStep);
    //size = 0x155;
    //WriteProtected(0x1408FDC4B, size);
    
    MemcpyProtected(0x1408E7E2C, 18, moveMapListStepPatch);
    
    //Quick and Dirty
    //Hook((LPVOID)0x1408FDC61, 5, &tInitMoveMapListStep, &bInitMoveMapListStep);

    //Proper
    Hook((LPVOID)0x1408FDC13, 7, &tGameStepSelection, &bGameStepSelection);

    Hook((LPVOID)0x140D4E027, 7, &tLoadDbgFont, &bLoadDbgFont);

    //Fix WindWorld option
    MemcpyProtected(0x140CDC43F, 2, nopBytes);

    //Features -- Freecam (A + L3)
    //MemcpyProtected(0x14062C3AE, 5, pFreeCamBytes1);
    //MemcpyProtected(0x14062C401, 31, pFreeCamBytes2);

    //Disable Gesture Menu
    MemcpyProtected(0x140B2D583, 1, pGestureBytes);

    uint64_t DbgDispLoadingAddress = (uint64_t)&fDbgDispLoading;
    //MemcpyProtected(0x144587EC8, 8, &DbgDispLoadingAddress);
    WriteProtected(0x144587EC8, (long long)DbgDispLoadingAddress);

    MemcpyProtected(0x140022909, 2, nopBytes); //-- Enable Cubemap Generation nodes

    
    //MemcpyProtected(0x140EE7C01, 4, &dBypassCheck2); //This check restores this one ^

    //Dbg font loading
    MemcpyProtected(0x142346F45, 2, dbgFontPatch);

    //Temporarily patch anti-tamper
    DWORD64 lol = 0;
    Hook((LPVOID)0x1408E7897, 5, &patchMoveMapFinishAntiTamper, &lol);

    MemcpyProtected(0x140B33BCD, 2, jmpBytes);

    Hook((LPVOID)0x1408D475E, 5, &tCheckDebugDashSwitch, &bCheckDebugDashSwitch);

    //why am I calling this twice
    //Hook((LPVOID)0x14080905B, 7, &tLoadGameProperties, &bLoadGameProperties);

    //Protecting saves from getting fucked in movemap
    MemcpyProtected(0x140626DED, 5, checkProfileIdxPatch);
    Hook((LPVOID)0x140626F4A, 8, &tMoveMapSaveFix, &bMoveMapSaveFix);

    Hook((LPVOID)0x140D49F15, 7, &ClearRenderTargetViewGrey, &bClearRenderTargetViewGrey);

    //Sleep(4000);

    //Enable ChrDbgDraw
    //MemcpyProtected(0x1408D8049, 5, mov1ToAlBytes);
}

void AddExceptionHandler()
{
    //Sleep(20000);

    SetUnhandledExceptionFilter(UHFilter);

    //MessageBox(NULL, L"HAHAHA", L"HA", MB_ICONWARNING);
}

void EarlyPatches()
{
    //most important
    MemcpyProtected(0x140ECDCE4, 5, mov1ToAlBytes);

    //Boot Menu
    WriteProtected(0x142720800, (long long)&initDebugBootMenuStepFunctions);
}

void AddCOPYPatch(uint64_t address, BYTE* bytes, int numBytes, BYTE lastByteCheck, int reapplyCount = 0)
{
    PatchJob pj;
    pj.type = COPY;
    pj.address = (BYTE*)address;
    pj.bytes = bytes;
    pj.numBytes = numBytes;
    pj.lastByteCheck = lastByteCheck;
    pj.reapplyCount = reapplyCount;

    patchJobs.push_back(pj);
}

void AddHOOKPatch(uint64_t address, int numBytes, BYTE fifthByteCheck, void* pFunction, DWORD64* pReturn, int reapplyCount = 0)
{
    PatchJob pj;
    pj.type = HOOK;
    pj.address = (BYTE*)address;
    pj.numBytes = numBytes;
    pj.lastByteCheck = fifthByteCheck;
    pj.pFunction = pFunction;
    pj.pReturn = pReturn;
    pj.reapplyCount = reapplyCount;

    patchJobs.push_back(pj);
}

void AddPatches()
{
    AddCOPYPatch(0x14080A2F0, mov1ToAlBytes, 2, 0xC0, 1);
    AddCOPYPatch(0x14080A2E0, mov1ToAlBytes, 2, 0xC0, 1);
    AddCOPYPatch(0x140E82DEE, xorRaxBytes, 5, 1, 1);
    //AddCOPYPatch(0x14062C3AE, pFreeCamBytes1, 5, 0, 1);
    //AddCOPYPatch(0x14062C401, pFreeCamBytes2, 31, 0, 1); //doesnt work, but not causing crash
    //AddCOPYPatch(0x1408D8049, mov1ToAlBytes, 5, 0xFF); //remove
    AddCOPYPatch(0x1408B1CF1, dBypassCheck1, 4, 1, 1);
    AddCOPYPatch(0x140EE7C01, dBypassCheck2, 4, 4);
    AddCOPYPatch(0x140EC365F, systemPropertiesValue, 1, 1, 1);
    AddHOOKPatch(0x14080905B, 7, 0xF5, &tLoadGameProperties, &bLoadGameProperties, 1);
    AddHOOKPatch(0x1422ED2FC, 6, 0x8B, &decWindowCounter, &bDecWindowCounter);
    AddHOOKPatch(0x1422F0522, 7, 0, &incWindowCounter, &bIncWindowCounter);
    AddCOPYPatch(0x140250A5F, sfxGUIPatch1, 16, 0x60);
    AddHOOKPatch(0x140ED1440, 5, 0, &tInitDebugBootMenuStep, &bInitDebugBootMenuStep);
    AddCOPYPatch(0x1408E7E2C, moveMapListStepPatch, 18, 0x20);
    AddHOOKPatch(0x1408FDC13, 7, 0x8D, &tGameStepSelection, &bGameStepSelection);
    AddHOOKPatch(0x140D4E027, 7, 1, &tLoadDbgFont, &bLoadDbgFont);
    AddCOPYPatch(0x140CDC43F, nopBytes, 2, 0x3E);
    AddCOPYPatch(0x140B2D583, pGestureBytes, 1, 0x74);
    AddCOPYPatch(0x144587EC8, (BYTE*)&DbgDispLoadingAddress, 8, 0);
    AddCOPYPatch(0x140022909, nopBytes, 2, 0x7F);
    AddCOPYPatch(0x142346F45, dbgFontPatch, 2, 0x10);
    AddHOOKPatch(0x1408E7897, 5, 0, &patchMoveMapFinishAntiTamper, &whatever);
    AddCOPYPatch(0x140B33BCD, jmpBytes, 2, 0x71);
    AddHOOKPatch(0x1408D475E, 5, 8, &tCheckDebugDashSwitch, &bCheckDebugDashSwitch);
    //AddCOPYPatch(0x140626DED, checkProfileIdxPatch, 5, 0x0A); //remove
    AddHOOKPatch(0x140626F4A, 8, 0x0A, &tMoveMapSaveFix, &bMoveMapSaveFix);
    AddHOOKPatch(0x140950074, 11, 0, DisableSave, &bDisableSave);
    AddHOOKPatch(0x140901117, 5, 0x48, EnableSave, &bEnableSave);
    AddHOOKPatch(0x140626DE6, 7, 0x0A, CheckSaveDisabled, &bCheckSaveDisabled);
    AddHOOKPatch(0x140D49F15, 7, 0xE5, &ClearRenderTargetViewGrey, &bClearRenderTargetViewGrey);
    AddCOPYPatch(0x140ECDCE4, mov1ToAlBytes, 5, 0xFF);
    AddCOPYPatch(0x142720800, (BYTE*)&pinitDebugBootMenuStepFunctions, 8, 0);
    
    //AddCOPYPatch(0x145E42FA8, nopBytes, 2, 0);
    //AddCOPYPatch(0x145D64410, nopBytes, 3, 1);
    //AddCOPYPatch(0x1458BFE5E, nopBytes, 3, 0);
}

//this is ONLY for patches that aren't critical on boot, but need to be delayed for reasons
void DelayedPatchesNew()
{
    Sleep(5000);

    MemcpyProtected(0x14062C3AE, 5, pFreeCamBytes1);
    MemcpyProtected(0x14062C401, 31, pFreeCamBytes2);
}

PatchJob GrabPatchJob()
{
    PatchJob pjReturn;
    pjReturn.type = INVALID;

    //pjMutex.lock();
    WaitForSingleObject(pjMutex, INFINITE);

    if (!patchJobs.empty())
    {
        pjReturn = patchJobs.back();
        patchJobs.pop_back();
    }

    //pjMutex.unlock();
    ReleaseMutex(pjMutex);

    return pjReturn;
}

void lalalala()
{

}

void PatchThread(LPVOID pId)
{
    int id = *static_cast<int*>(pId);
    
    vector<PatchJob> threadPatchJobs;
    vector<PatchJob>::iterator it;
    bool grabPatchJob = true;
    bool jobDone = true;

    while (true)
    {
        jobDone = true;

        if (grabPatchJob)
        {
            PatchJob pj = GrabPatchJob();

            if (pj.type != INVALID)
            {
                threadPatchJobs.push_back(pj);
            }
            else 
            {
                grabPatchJob = false;
                threadStartupMarkers[id] = true;
            }
                
        }

        for (it = threadPatchJobs.begin(); it != threadPatchJobs.end(); it++) {
           
            if (it->type == COPY)
            {
                jobDone = false;

                if (*(it->address + it->numBytes - 1) == it->lastByteCheck)
                {
                    //memcpy(it->address, it->bytes, it->numBytes);
                    MemcpyProtected((uint64_t)it->address, it->numBytes, it->bytes);

                    if (it->reapplyCount == 0)
                        it->type = INVALID;
                    else
                        it->reapplyCount--;
                }
            }
            else if (it->type == HOOK)
            {
                jobDone = false;

                if (*(it->address + 4) == it->lastByteCheck)
                {
                    //threadShitMarkers[id]++;
                    MH_DisableHook(it->address);
                    Hook(it->address, it->numBytes, it->pFunction, it->pReturn);

                    if (it->reapplyCount == 0)
                        it->type = INVALID;
                    else
                    {
                        
                        it->reapplyCount--;
                    }
                        
                }
            }
        }

        if (!grabPatchJob && jobDone)
            break;
    }

    threadFinishMarkers[id] = true;
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
    HANDLE thread2;
    static HMODULE dinput8dll = nullptr;
    HMODULE chainModule = NULL;
    wchar_t chainPath[MAX_PATH];
    wchar_t dllPath[MAX_PATH];

    //wchar_t buff[100];
    //swprintf_s(buff, L"bytes is:%d", patchJobs[0][0].numBytes);

    //MessageBox(NULL, (LPCWSTR)buff, L"Msg title", MB_OK | MB_ICONQUESTION);
    //EarlyPatches();
    
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
    {
        
        for (int i = 0; i < NUM_PATCH_THREADS; i++)
        {
            threadIndices[i] = i;
            //patchJobs.push_back(vector<PatchJob>());
        }

        AddPatches();

        GetPrivateProfileStringW(L"misc", L"dinput8DllWrapper", L"", chainPath, MAX_PATH, L".\\debugmenu.ini");

        if (chainPath && wcscmp(chainPath, L""))
        {
            GetCurrentDirectoryW(MAX_PATH, dllPath);
            wcscat_s(dllPath, MAX_PATH, L"\\");
            wcscat_s(dllPath, MAX_PATH, chainPath);
            chainModule = LoadLibraryW(dllPath);

            if (chainModule)
            {
                oDirectInput8Create = (tDirectInput8Create)GetProcAddress(chainModule, "DirectInput8Create");
            }
        }

        if (!chainModule)
        {
            wchar_t path[MAX_PATH];
            GetSystemDirectoryW(path, MAX_PATH);
            wcscat_s(path, MAX_PATH, L"\\dinput8.dll");
            dinput8dll = LoadLibraryW(path);

            if (dinput8dll)
            {
                oDirectInput8Create = (tDirectInput8Create)GetProcAddress(dinput8dll, "DirectInput8Create");
            }
        }


        SetUpVtables();

        //Sleep(10000);

        MH_Initialize();
        //CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)AddExceptionHandler, hModule, NULL, NULL);
        for (int i = 0; i < NUM_PATCH_THREADS; i++)
        {
            //patchingThreads[i] = thread(lalalala);
            patchingThreads[i] = CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)PatchThread, (LPVOID)&threadIndices[i], NULL, NULL);
        }

        bool threadsStarted = false;
        int checkedThreadIdx = 0;

        while (true)
        {
            if (threadStartupMarkers[checkedThreadIdx])
            {
                checkedThreadIdx++;
            }

            if (checkedThreadIdx == NUM_PATCH_THREADS)
                break;
        }

        CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)AddExceptionHandler, NULL, NULL, NULL);
        //EarlyPatches();
        //PatchFunctionTable();
        //PatchEsdDbgLogOutput();
        //PatchEzStateActionEnvJumpTable();

        
        CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)DelayedPatchesNew, hModule, NULL, NULL);
        //CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)ExtraDelayedPatches, hModule, NULL, NULL);



        break;
    }
    case DLL_THREAD_ATTACH:
        break;
    case DLL_THREAD_DETACH:
        break;
    case DLL_PROCESS_DETACH:
        
        if (chainModule)
        {
            FreeLibrary(chainModule);
        }
        else {
            FreeLibrary(dinput8dll);
        }

        MH_DisableHook(MH_ALL_HOOKS);
        MH_Uninitialize();

        for (int i = 0; i < NUM_PATCH_THREADS; i++)
        {
            CloseHandle(patchingThreads[i]);
        }

        delete[] debugBootMenuStepVtable;
        delete[] EzTextlistSelectorVtable;
        delete[] MoveMapListStepVtable;

        break;
    }
    return TRUE;
}

LONG WINAPI UHFilter(struct _EXCEPTION_POINTERS* apExceptionInfo) {

    DWORD ExceptionCode = apExceptionInfo->ExceptionRecord->ExceptionCode;
    DWORD ExceptionFlags = apExceptionInfo->ExceptionRecord->ExceptionFlags;
    DWORD64 FaultOffset = (DWORD64)apExceptionInfo->ExceptionRecord->ExceptionAddress;
    DWORD NumberParameters = apExceptionInfo->ExceptionRecord->NumberParameters;
    FILE* fp;
    LPCWSTR ExceptionString = L"INVALID";

    AllocConsole();
    freopen_s(&fp, "CONIN$", "r", stdin);
    freopen_s(&fp, "CONOUT$", "w", stdout);

    switch (ExceptionCode) {
    case(EXCEPTION_ACCESS_VIOLATION): ExceptionString = L"ACCESS VIOLATION"; break;
    case(EXCEPTION_ARRAY_BOUNDS_EXCEEDED): ExceptionString = L"OUT OF BOUNDS"; break;
    case(EXCEPTION_BREAKPOINT): ExceptionString = L"BREAKPOINT REACHED"; break;
    case(EXCEPTION_DATATYPE_MISALIGNMENT): ExceptionString = L"MISALIGNED DATA"; break;
    case(EXCEPTION_FLT_DENORMAL_OPERAND): ExceptionString = L"FLOAT TOO SMALL"; break;
    case(EXCEPTION_FLT_DIVIDE_BY_ZERO): ExceptionString = L"FLOAT DIV 0"; break;
    case(EXCEPTION_FLT_INEXACT_RESULT): ExceptionString = L"FLOAT RESULT ERROR"; break;
    case(EXCEPTION_FLT_INVALID_OPERATION): ExceptionString = L"FLOAT ERROR"; break;
    case(EXCEPTION_FLT_OVERFLOW): ExceptionString = L"FLOAT OVERFLOW"; break;
    case(EXCEPTION_FLT_STACK_CHECK): ExceptionString = L"FLOAT DERIVED STACK ERROR"; break;
    case(EXCEPTION_FLT_UNDERFLOW): ExceptionString = L"FLOAT UNDERFLOW"; break;
    case(EXCEPTION_ILLEGAL_INSTRUCTION): ExceptionString = L"ILLEGAL INSTRUCTION"; break;
    case(EXCEPTION_IN_PAGE_ERROR): ExceptionString = L"PAGE ERROR"; break;
    case(EXCEPTION_INT_DIVIDE_BY_ZERO): ExceptionString = L"INT DIV 0"; break;
    case(EXCEPTION_INT_OVERFLOW): ExceptionString = L"INTEGER OVERFLOW"; break;
    case(EXCEPTION_INVALID_DISPOSITION): ExceptionString = L"INVALID DISPOSITION"; break;
    case(EXCEPTION_NONCONTINUABLE_EXCEPTION): ExceptionString = L"BYPASSED UNHANDLED EXCEPTION"; break;
    case(EXCEPTION_PRIV_INSTRUCTION): ExceptionString = L"PRIVATE INSTRUCTION"; break;
    case(EXCEPTION_SINGLE_STEP): ExceptionString = L"SINGLE STEP OPERATION COMPLETED"; break;
    case(EXCEPTION_STACK_OVERFLOW): ExceptionString = L"STACK OVERFLOW"; break;
    };

    wprintf_s(L"----- [YuiSpy Activated] -----\n\n");
    wprintf_s(L"Exception Code: 0x%X (%s)\n", ExceptionCode, ExceptionString);
    wprintf_s(L"Exception Flags: %X\n", ExceptionFlags);
    wprintf_s(L"Fault Offset: 0x%llX\n", FaultOffset);
    wprintf_s(L"Number Parameters: %X\n", NumberParameters);

    if (ExceptionCode == EXCEPTION_ACCESS_VIOLATION) {
        DWORD64 InaccessbileMem = (DWORD64)apExceptionInfo->ExceptionRecord->ExceptionInformation[1];
        if (apExceptionInfo->ExceptionRecord->ExceptionInformation[0] == 0) {
            wprintf_s(L"The instruction at 0x%llX referenced memory at 0x%llX. The memory could not be read.\n", FaultOffset, InaccessbileMem);
        }
        else {
            wprintf_s(L"The instruction at 0x%llX referenced memory at 0x%llX. The memory could not be written.\n", FaultOffset, InaccessbileMem);
        };
    };

    wprintf_s(L"Generating register dump:\n");
    wprintf_s(L"RAX: 0x%llX\n", apExceptionInfo->ContextRecord->Rax);
    wprintf_s(L"RBX: 0x%llX\n", apExceptionInfo->ContextRecord->Rbx);
    wprintf_s(L"RCX: 0x%llX\n", apExceptionInfo->ContextRecord->Rcx);
    wprintf_s(L"RDX: 0x%llX\n", apExceptionInfo->ContextRecord->Rdx);
    wprintf_s(L"RDI: 0x%llX\n", apExceptionInfo->ContextRecord->Rdi);
    wprintf_s(L"RSI: 0x%llX\n", apExceptionInfo->ContextRecord->Rsi);
    wprintf_s(L"R8:  0x%llX\n", apExceptionInfo->ContextRecord->R8);
    wprintf_s(L"R9:  0x%llX\n", apExceptionInfo->ContextRecord->R9);
    wprintf_s(L"R10: 0x%llX\n", apExceptionInfo->ContextRecord->R10);
    wprintf_s(L"R11: 0x%llX\n", apExceptionInfo->ContextRecord->R11);
    wprintf_s(L"R12: 0x%llX\n", apExceptionInfo->ContextRecord->R12);
    wprintf_s(L"R13: 0x%llX\n", apExceptionInfo->ContextRecord->R13);
    wprintf_s(L"R14: 0x%llX\n", apExceptionInfo->ContextRecord->R14);
    wprintf_s(L"R15: 0x%llX\n", apExceptionInfo->ContextRecord->R15);

    wprintf_s(L"RBP: 0x%llX\n", apExceptionInfo->ContextRecord->Rbp);
    wprintf_s(L"RSP: 0x%llX\n\n", apExceptionInfo->ContextRecord->Rsp);

    wprintf_s(L"------ [YuiSpy Complete] -----");

    MessageBoxA(NULL, "The application has crashed.", "YuiSpy", MB_ICONERROR);

    FreeConsole();

    exit(1);

};


;	The pictures. A map is one file: the 8-byte header, the tiles, the palette
;	and the map. The tiles start eight bytes in.

unk_8F2C6	;A map used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_8F2C6.map.jim

unk_90686	;A map used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_90686.map.jim

unk_911B8	;A map used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_911B8.map.jim

Framermap	;The Framermap map (Framer); +8 the framer tiles
	incbin	..\Extracted\NHL96\Graphics\Framermap.map.jim

FaceOffMap	;The face-off map; +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\FaceOffMap.map.jim

Rinktilelist	;The ice rink map; Rinktilelist+8 = the rink tiles
	incbin	..\Extracted\NHL96\Graphics\Rinktilelist.map.jim

RefTiles	;The RefTiles map (the ref window)
	incbin	..\Extracted\NHL96\Graphics\RefTiles.map.jim

RefTilesHor	;The RefTilesHor map (the ref window, horizontal rink)
	incbin	..\Extracted\NHL96\Graphics\RefTilesHor.map.jim

Sprites	;The sprite header: the offsets of the palette and of frameSprData (data96_06), then the tile count
	incbin	..\Extracted\NHL96\Graphics\Sprites.bin

Spritetiles	;The sprite tiles (continued in data96_06)
	incbin	..\Extracted\NHL96\Graphics\Spritetiles.bin

SpritePalette	;The sprite palette (the Sprites header's first offset)
	incbin	..\Extracted\NHL96\Graphics\SpritePalette.bin

frameSprData	;The sprite frame data (the Sprites header's second offset)
	incbin	..\Extracted\NHL96\Graphics\frameSprData.bin

HotList	;The hot spot byte pair of each frame (GetHot)
	incbin	..\Extracted\NHL96\Graphics\HotList.bin

HotList2	;The hot spot list of the GetHot variants
	incbin	..\Extracted\NHL96\Graphics\HotList2.bin

CrowdFrameList	;The crowd sprite frames (showcrowd); +8 the crowd tiles (animchars)
	incbin	..\Extracted\NHL96\Graphics\CrowdFrameList.map.jim

FaceOffSprites	;The face-off sprites (checkfo); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\FaceOffSprites.map.jim

EnergyBarMap	;The EnergyBarMap map
	incbin	..\Extracted\NHL96\Graphics\EnergyBarMap.map.jim

EASNmap	;The EASN logo map (EASNLogo); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\EASNmap.map.jim

EASportsMap	;The EA Sports screen map (EASportsScreen)
	incbin	..\Extracted\NHL96\Graphics\EASportsMap.map.jim

RevRinkTilelist	;The ice rink map rows of a reverse angle replay (updatescroll)
	incbin	..\Extracted\NHL96\Graphics\RevRinkTilelist.bin

ReplayIconMap	;The replay icon map (ShowReplayIcon); continued in data96_07
	incbin	..\Extracted\NHL96\Graphics\ReplayIconMap.map.jim

ReplayBannerMap	;The replay banner map (ShowReplayBanner)
	incbin	..\Extracted\NHL96\Graphics\ReplayBannerMap.map.jim

unk_1417B6	;A map used from code96_14
	incbin	..\Extracted\NHL96\Graphics\unk_1417B6.map.jim

unk_1468D6	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_1468D6.map.jim

unk_147896	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_147896.map.jim

TeamBlockANH	;The setup team block bitmap of ANH (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockANH.map.jim

TeamBlockBOS	;The setup team block bitmap of BOS (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockBOS.map.jim

TeamBlockBUF	;The setup team block bitmap of BUF (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockBUF.map.jim

TeamBlockCGY	;The setup team block bitmap of CGY (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockCGY.map.jim

TeamBlockCHI	;The setup team block bitmap of CHI (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockCHI.map.jim

TeamBlockDAL	;The setup team block bitmap of DAL (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockDAL.map.jim

TeamBlockDET	;The setup team block bitmap of DET (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockDET.map.jim

TeamBlockEDM	;The setup team block bitmap of EDM (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockEDM.map.jim

TeamBlockFLA	;The setup team block bitmap of FLA (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockFLA.map.jim

TeamBlockHFD	;The setup team block bitmap of HFD (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockHFD.map.jim

TeamBlockLA	;The setup team block bitmap of LA (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockLA.map.jim

TeamBlockMTL	;The setup team block bitmap of MTL (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockMTL.map.jim

TeamBlockNJ	;The setup team block bitmap of NJ (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockNJ.map.jim

TeamBlockNYI	;The setup team block bitmap of NYI (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockNYI.map.jim

TeamBlockNYR	;The setup team block bitmap of NYR (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockNYR.map.jim

TeamBlockOTW	;The setup team block bitmap of OTW (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockOTW.map.jim

TeamBlockPHI	;The setup team block bitmap of PHI (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockPHI.map.jim

TeamBlockPIT	;The setup team block bitmap of PIT (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockPIT.map.jim

TeamBlockQUE	;The setup team block bitmap of QUE (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockQUE.map.jim

TeamBlockSJ	;The setup team block bitmap of SJ (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockSJ.map.jim

TeamBlockSTL	;The setup team block bitmap of STL (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockSTL.map.jim

TeamBlockTB	;The setup team block bitmap of TB (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockTB.map.jim

TeamBlockTOR	;The setup team block bitmap of TOR (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockTOR.map.jim

TeamBlockVAN	;The setup team block bitmap of VAN (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockVAN.map.jim

TeamBlockWSH	;The setup team block bitmap of WSH (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockWSH.map.jim

TeamBlockWPG	;The setup team block bitmap of WPG (TeamBlockPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamBlockWPG.map.jim

TeamLogoANH	;The team logo bitmap of ANH (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoANH.map.jim

TeamLogoBOS	;The team logo bitmap of BOS (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoBOS.map.jim

TeamLogoBUF	;The team logo bitmap of BUF (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoBUF.map.jim

TeamLogoCGY	;The team logo bitmap of CGY (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoCGY.map.jim

TeamLogoCHI	;The team logo bitmap of CHI (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoCHI.map.jim

TeamLogoDAL	;The team logo bitmap of DAL (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoDAL.map.jim

TeamLogoDET	;The team logo bitmap of DET (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoDET.map.jim

TeamLogoEDM	;The team logo bitmap of EDM (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoEDM.map.jim

TeamLogoFLA	;The team logo bitmap of FLA (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoFLA.map.jim

TeamLogoHFD	;The team logo bitmap of HFD (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoHFD.map.jim

TeamLogoLA	;The team logo bitmap of LA (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoLA.map.jim

TeamLogoMTL	;The team logo bitmap of MTL (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoMTL.map.jim

TeamLogoNJ	;The team logo bitmap of NJ (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoNJ.map.jim

TeamLogoNYI	;The team logo bitmap of NYI (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoNYI.map.jim

TeamLogoNYR	;The team logo bitmap of NYR (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoNYR.map.jim

TeamLogoOTW	;The team logo bitmap of OTW (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoOTW.map.jim

TeamLogoPHI	;The team logo bitmap of PHI (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoPHI.map.jim

TeamLogoPIT	;The team logo bitmap of PIT (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoPIT.map.jim

TeamLogoQUE	;The team logo bitmap of QUE (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoQUE.map.jim

TeamLogoSJ	;The team logo bitmap of SJ (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoSJ.map.jim

TeamLogoSTL	;The team logo bitmap of STL (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoSTL.map.jim

TeamLogoTB	;The team logo bitmap of TB (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoTB.map.jim

TeamLogoTOR	;The team logo bitmap of TOR (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoTOR.map.jim

TeamLogoVAN	;The team logo bitmap of VAN (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoVAN.map.jim

TeamLogoWSH	;The team logo bitmap of WSH (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoWSH.map.jim

TeamLogoWPG	;The team logo bitmap of WPG (TeamLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\TeamLogoWPG.map.jim

SmallLogoFLA	;The small team logo of FLA (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoFLA.map.jim

SmallLogoBUF	;The small team logo of BUF (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoBUF.map.jim

SmallLogoANH	;The small team logo of ANH (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoANH.map.jim

SmallLogoBOS	;The small team logo of BOS (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoBOS.map.jim

SmallLogoCGY	;The small team logo of CGY (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoCGY.map.jim

SmallLogoCHI	;The small team logo of CHI (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoCHI.map.jim

SmallLogoDAL	;The small team logo of DAL (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoDAL.map.jim

SmallLogoDET	;The small team logo of DET (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoDET.map.jim

SmallLogoEDM	;The small team logo of EDM (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoEDM.map.jim

SmallLogoHFD	;The small team logo of HFD (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoHFD.map.jim

SmallLogoLA	;The small team logo of LA (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoLA.map.jim

SmallLogoMTL	;The small team logo of MTL (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoMTL.map.jim

SmallLogoNJ	;The small team logo of NJ (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoNJ.map.jim

SmallLogoNYI	;The small team logo of NYI (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoNYI.map.jim

SmallLogoNYR	;The small team logo of NYR (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoNYR.map.jim

SmallLogoOTW	;The small team logo of OTW (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoOTW.map.jim

SmallLogoPHI	;The small team logo of PHI (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoPHI.map.jim

SmallLogoPIT	;The small team logo of PIT (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoPIT.map.jim

SmallLogoQUE	;The small team logo of QUE (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoQUE.map.jim

SmallLogoSJ	;The small team logo of SJ (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoSJ.map.jim

SmallLogoSTL	;The small team logo of STL (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoSTL.map.jim

SmallLogoTB	;The small team logo of TB (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoTB.map.jim

SmallLogoTOR	;The small team logo of TOR (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoTOR.map.jim

SmallLogoVAN	;The small team logo of VAN (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoVAN.map.jim

SmallLogoWSH	;The small team logo of WSH (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoWSH.map.jim

SmallLogoWPG	;The small team logo of WPG (SmallLogoPtrs)
	incbin	..\Extracted\NHL96\Graphics\SmallLogoWPG.map.jim

unk_170B0C	;A map used from code96_05 and code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_170B0C.map.jim

ControllerBgMap	;The controller setup screen background map (ControllerSetupScreen)
	incbin	..\Extracted\NHL96\Graphics\ControllerBgMap.map.jim

RosterFont	;The roster font map (smallfontptr); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\RosterFont.bin

SmallFontMap	;The small font map (print); +8 the tiles (LoadSmallFont)
	incbin	..\Extracted\NHL96\Graphics\SmallFontMap.map.jim

SmallFontMap2	;The second small font map; +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\SmallFontMap2.map.jim

BigFontMap2	;The big font map (printbig, bigfontptr); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\BigFontMap2.map.jim

BigFontMap4	;The big font map printbig takes with sflags11 bit 2; +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\BigFontMap4.map.jim

unk_17C2AE	;Data used from code96_16, code96_17, code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_17C2AE.map.jim

unk_17C2CE	;A map used from code96_05
	incbin	..\Extracted\NHL96\Graphics\unk_17C2CE.map.jim

unk_17DBDC	;A map used from code96_05
	incbin	..\Extracted\NHL96\Graphics\unk_17DBDC.map.jim

unk_17E3FC	;Data used from code96_05
	incbin	..\Extracted\NHL96\Graphics\unk_17E3FC.map.jim

unk_17ECEA	;A map used from code96_05
	incbin	..\Extracted\NHL96\Graphics\unk_17ECEA.map.jim

unk_1808B8	;Data used from code96_05
	incbin	..\Extracted\NHL96\Graphics\unk_1808B8.map.jim

unk_180C36	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_180C36.map.jim

unk_181456	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_181456.map.jim

unk_183024	;Data used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_183024.map.jim

unk_1833A2	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_1833A2.map.jim

unk_185770	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_185770.map.jim

unk_185F90	;Data used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_185F90.map.jim

unk_18633E	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_18633E.map.jim

unk_18800C	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_18800C.map.jim

unk_18882C	;Data used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_18882C.map.jim

unk_188C4A	;A map used from code96_15
	incbin	..\Extracted\NHL96\Graphics\unk_188C4A.map.jim

unk_18948A	;A map used from code96_16, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_18948A.map.jim

unk_18ACD8	;A map used from code96_16
	incbin	..\Extracted\NHL96\Graphics\unk_18ACD8.map.jim

unk_18B4F8	;Data used from code96_15, code96_16, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_18B4F8.map.jim

unk_18B916	;A map used from code96_16, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_18B916.map.jim

unk_18C136	;A map used from code96_05
	incbin	..\Extracted\NHL96\Graphics\unk_18C136.map.jim

unk_18C936	;A map used from code96_05
	incbin	..\Extracted\NHL96\Graphics\unk_18C936.map.jim

unk_18DE04	;Data used from code96_05, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_18DE04.map.jim

unk_18E152	;A map used from code96_16
	incbin	..\Extracted\NHL96\Graphics\unk_18E152.map.jim

unk_18E932	;A map used from code96_16
	incbin	..\Extracted\NHL96\Graphics\unk_18E932.map.jim

unk_190380	;Data used from code96_16
	incbin	..\Extracted\NHL96\Graphics\unk_190380.map.jim

unk_1906FE	;A map used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_1906FE.map.jim

unk_190EFE	;A map used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_190EFE.map.jim

unk_19262C	;Data used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_19262C.map.jim

unk_1929FA	;A map used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_1929FA.map.jim

unk_19321A	;A map used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_19321A.map.jim

unk_194C48	;Data used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_194C48.map.jim

unk_195086	;A map used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_195086.map.jim

unk_1969B4	;Data used from data96_11
	incbin	..\Extracted\NHL96\Graphics\unk_1969B4.map.jim

unk_196E0A	;A map used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_196E0A.map.jim

unk_19762A	;Data used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_19762A.map.jim

unk_197A60	;A map used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_197A60.map.jim

unk_198260	;A map used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_198260.map.jim

unk_1997AE	;Data used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_1997AE.map.jim

unk_199BE4	;A map used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_199BE4.map.jim

unk_19A3E4	;A map used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_19A3E4.map.jim

unk_19C232	;Data used from code96_17
	incbin	..\Extracted\NHL96\Graphics\unk_19C232.map.jim

unk_19C628	;A map used from code96_18, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_19C628.map.jim

unk_19CE08	;A map used from code96_18, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_19CE08.map.jim

unk_19E7F6	;A map used from code96_18, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_19E7F6.map.jim

unk_1A0244	;Data used from code96_18, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A0244.map.jim

unk_1A0632	;Data used from code96_18, data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A0632.map.jim

unk_1A0A58	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A0A58.map.jim

unk_1A1EC6	;Data used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A1EC6.map.jim

unk_1A22FC	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A22FC.map.jim

unk_1A2B1C	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A2B1C.map.jim

unk_1A454A	;Data used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A454A.map.jim

unk_1A4968	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A4968.map.jim

unk_1A5148	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A5148.map.jim

unk_1A5928	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A5928.map.jim

unk_1A6148	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A6148.map.jim

unk_1A76B6	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A76B6.map.jim

unk_1A7ED6	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A7ED6.map.jim

unk_1A98A4	;Data used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A98A4.map.jim

unk_1A9C72	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1A9C72.map.jim

unk_1AA452	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1AA452.map.jim

unk_1AAC72	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1AAC72.map.jim

unk_1AC3A0	;Data used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1AC3A0.map.jim

unk_1AC7C6	;A map used from data96_12
	incbin	..\Extracted\NHL96\Graphics\unk_1AC7C6.map.jim

unk_1ACFE6	;A map used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1ACFE6.map.jim

unk_1AD7C6	;A map used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1AD7C6.map.jim

unk_1AEB94	;Data used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1AEB94.map.jim

unk_1AEF62	;A map used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1AEF62.map.jim

unk_1AF782	;A map used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1AF782.map.jim

unk_1B11B0	;A map used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1B11B0.map.jim

PresidentsPic	;Award picture: Presidents Trophy
	incbin	..\Extracted\NHL96\Graphics\PresidentsPic.map.jim

ArtRossPic	;Award picture: Art Ross Trophy
	incbin	..\Extracted\NHL96\Graphics\ArtRossPic.map.jim

NorrisPic	;Award picture: James Norris Trophy
	incbin	..\Extracted\NHL96\Graphics\NorrisPic.map.jim

VezinaPic	;Award picture: Vezina Trophy
	incbin	..\Extracted\NHL96\Graphics\VezinaPic.map.jim

CampbellPic	;Award picture: Clarence Campbell Bowl
	incbin	..\Extracted\NHL96\Graphics\CampbellPic.map.jim

WalesPic	;Award picture: Prince of Wales Trophy
	incbin	..\Extracted\NHL96\Graphics\WalesPic.map.jim

HartPic	;Award picture: Hart Memorial Trophy (SeasonAwards)
	incbin	..\Extracted\NHL96\Graphics\HartPic.map.jim

ConnSmythePic	;Award picture: Conn Smythe Trophy
	incbin	..\Extracted\NHL96\Graphics\ConnSmythePic.map.jim

PearsonPic	;Award picture: Lester B. Pearson Award
	incbin	..\Extracted\NHL96\Graphics\PearsonPic.map.jim

PadIconMap1	;Pad icon map 1 (PadIconMaps); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\PadIconMap1.map.jim

PadIconMap2	;Pad icon map 2 (PadIconMaps); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\PadIconMap2.map.jim

PadIconMap3	;Pad icon map 3 (PadIconMaps); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\PadIconMap3.map.jim

PadIconMap4	;Pad icon map 4 (PadIconMaps); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\PadIconMap4.map.jim

PadCursorMap	;The pad cursor map (DrawPadIcon); +8 the tiles
	incbin	..\Extracted\NHL96\Graphics\PadCursorMap.map.jim

ControllerTitleMap	;The controller setup screen title map (ControllerSetupScreen)
	incbin	..\Extracted\NHL96\Graphics\ControllerTitleMap.map.jim

unk_1B773A	;A map used from the controller setup
	incbin	..\Extracted\NHL96\Graphics\unk_1B773A.map.jim

BigFontMap	;The big font map of printbig1 (chars word_FFB016); +8 the tiles (LoadBigFonts)
	incbin	..\Extracted\NHL96\Graphics\BigFontMap.map.jim

BigFontMap3	;The big font map of printbig2 (chars BigFontChars); +8 the tiles (LoadBigFonts)
	incbin	..\Extracted\NHL96\Graphics\BigFontMap3.map.jim

unk_1B9ED8	;A map used from code96_09, code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_1B9ED8.map.jim

unk_1BA4BE	;A map used from code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_1BA4BE.map.jim

unk_1BBBEC	;A map used from code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_1BBBEC.map.jim

unk_1BCBFA	;Data used from code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_1BCBFA.map.jim

unk_1BCF78	;A map used from code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_1BCF78.map.jim

unk_1BD5E6	;A map used from code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_1BD5E6.map.jim

unk_1BDCD4	;Data used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1BDCD4.map.jim

unk_1C0302	;A map used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1C0302.map.jim

unk_1C4810	;A map used from code96_19
	incbin	..\Extracted\NHL96\Graphics\unk_1C4810.map.jim

unk_1C4C4E	;A map used from code96_15, code96_17, code96_18
	incbin	..\Extracted\NHL96\Graphics\unk_1C4C4E.map.jim

unk_1C6C4C	;A map used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_1C6C4C.map.jim

unk_1CAEFA	;A map used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_1CAEFA.map.jim

unk_1CCBA8	;Data used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_1CCBA8.map.jim

unk_1CCEE8	;Data used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_1CCEE8.map.jim

unk_1D5420	;A map used from code96_20
	incbin	..\Extracted\NHL96\Graphics\unk_1D5420.map.jim

unk_1D579E	;Data used from code96_06
	incbin	..\Extracted\NHL96\Graphics\unk_1D579E.map.jim

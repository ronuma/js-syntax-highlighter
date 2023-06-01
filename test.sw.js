// Example file of a real Next.js app

import {createSlice} from "@reduxjs/toolkit"

const instruments = createSlice({
   name: "instruments",
   initialState: {
      // ejemplo de como se verían los instrumentos
      // {id: 1, name: "Piano", selected: false}
      instruments: [],
      selectedInstrumentIds: [],
      noInstrumentsSelected: true,
      showModal: true,
   },
   reducers: {
      setInstruments: (state, action) => {
         state.instruments = action.payload
      },
      setShowModal: (state, action) => {
         state.showModal = action.payload
      },
      selectInstrument: (state, action) => {
         const index = state.instruments.findIndex(
            instrument => instrument.id === action.payload
         )
         state.instruments = state.instruments.map((instrument, i) => {
            if (i === index) {
               return {
                  ...instrument,
                  selected: !instrument.selected,
               }
            }
            return instrument
         })
         state.selectedInstrumentIds = state.instruments
            .filter(instrument => instrument.selected)
            .map(instrument => instrument.id)
         state.noInstrumentsSelected = state.instruments.every(
            instrument => !instrument.selected
         )
      },
   },
})

export function parseGenresArray(genres) {
   return genres.length > 1
      ? genres.map((genre, index) => {
           if (index < genres.length - 1) {
              return genre.name + ", "
           } else {
              return genre.name
           }
        })
      : genres[0].name
}

export function parseInstrumentsArray(instruments) {
   return instruments.length > 1
      ? instruments.map((instrument, index) => {
           if (index < instruments.length - 1) {
              return instrument.name + ", "
           } else {
              return instrument.name
           }
        })
      : instruments[0].name
}

export const {setInstruments, selectInstrument, setShowModal} =
   instruments.actions
export default instruments.reducer

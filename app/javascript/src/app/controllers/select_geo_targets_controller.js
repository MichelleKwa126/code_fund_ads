import { Controller } from 'stimulus';
import { toArray } from '../utils';

export default class extends Controller {
  static targets = ['countriesSelect', 'provincesSelect'];

  connect() {
    this.provinces = JSON.parse(this.provincesSelectTarget.dataset.provinces);
    this.updateProvinceOptions();
    this.preselectProvinceOptions();
  }

  updateProvinceOptions(event) {
    if (event && event.type === 'keyup' && event.key !== 'Enter') return;

    if (this.validProvinces.length === 0 || this.selectedCountries.length > 10) {
      this.provincesSelectTarget.innerHTML = '';
      this.provincesSelectTarget.disabled = true;
      this.provincesSelectTarget.closest('div[data-controller="select-multiple"]').hidden = true;
      this.provincesSelectTarget.dispatchEvent(new Event('change'));
      return;
    }

    this.provincesSelectTarget.disabled = false;
    this.provincesSelectTarget.closest('div[data-controller="select-multiple"]').hidden = false;
    this.removeInvalidProvinceOptions();
    this.addMissingProvinceOptions();
    this.provincesSelectTarget.dispatchEvent(new Event('change'));
  }

  removeInvalidProvinceOptions() {
    let valid = this.validProvinces;
    this.provinceOptions.forEach(o => {
      let match = valid.find(p => p.countryCode === o.dataset.countryCode);
      if (!match) o.remove();
    });
  }

  addMissingProvinceOptions() {
    let options = this.provinceOptions;
    this.validProvinces.forEach(p => {
      let match = options.find(o => o.dataset.countryCode === p.countryCode);
      if (!match) {
        let option = document.createElement('option');
        option.value = p.id;
        option.text = p.name;
        option.dataset.countryCode = p.countryCode;
        this.provincesSelectTarget.appendChild(option);
      }
    });
  }

  preselectProvinceOptions() {
    this.provinceOptions.forEach(o => {
      if (this.provincesSelectTarget.dataset.selected.indexOf(o.value) > 0) o.selected = true;
    });
  }

  get selectedCountries() {
    return toArray(this.countriesSelectTarget.querySelectorAll('option:checked')).map(o => o.value);
  }

  get provinceOptions() {
    return toArray(this.provincesSelectTarget.querySelectorAll('option'));
  }

  get validProvinces() {
    return this.provinces.filter(p => this.selectedCountries.find(c => c === p.countryCode));
  }

  //selectDevelopedMarkets(event) {
  //  Rails.stopEverything(event);
  //  developedMarkets.forEach(val => {
  //    let option = this.options.find(o => o.value === val);
  //    if (option) option.selected = true;
  //  });
  //  this.selectTarget.dispatchEvent(new Event('change'));
  //}
  //selectEmergingMarkets(event) {
  //  Rails.stopEverything(event);
  //  emergingMarkets.forEach(val => {
  //    let option = this.options.find(o => o.value === val);
  //    if (option) option.selected = true;
  //  });
  //  this.selectTarget.dispatchEvent(new Event('change'));
  //}
}
